//
//  MyProfileViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/27.
//

import UIKit
import PhotosUI
import FirebaseFirestore
//這個controller已整理完2023.09.08
class MyProfileViewController: UIViewController {
    
    // MARK: - Property
    
    private let tableView = UITableView(frame: .zero)
    private let imagePicker = UIImagePickerController()
    private var listener: ListenerRegistration?
    public var user: Account!
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listener = StoreManager.shared.listenUserData(id: user.userID) { account in
            self.user = account
            NotificationCenter.default.post(name: NSNotification.Name("updateView"), object: nil, userInfo: ["userInfoKey" : account])
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        imagePicker.delegate = self
        navigationItem.title = "個人資料"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleCancel))
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        listener?.remove()
    }
    
    // MARK: - Method
    
    @objc private func handleCancel() {
        self.dismiss(animated: true)
    }
    
    private func setupTableView() {
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        tableView.register(NameTableViewCell.self, forCellReuseIdentifier: NameTableViewCell.identifier)
        view.addSubview(tableView)

        tableView.backgroundColor = .systemBackground
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

// MARK: - UITableViewDataSource

extension MyProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath {
        case IndexPath(row: 0, section: 0):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as? PhotoTableViewCell else { return UITableViewCell() }
            let imageURL = URL(string: user.image)
            guard let imageURL = imageURL else { return UITableViewCell() }
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        if let image = image {
                            cell.updatePhoto(image: image)
                        } else {
                            cell.updatePhoto(image: UIImage(named: "Liz-Logo")!)
                        }
                    }
                }
            }.resume()
            cell.delegate = self
            return cell
            
        case IndexPath(row: 1, section: 0):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NameTableViewCell.identifier, for: indexPath) as? NameTableViewCell else { return UITableViewCell() }
            cell.updateNameLabel(text: user.name)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 0, section: 0) {
            return 120
        } else if indexPath == IndexPath(row: 1, section: 0) {
            return 100
        } else {
            return 60
        }
    }
    
}

// MARK: - UITableViewDelegate

extension MyProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            let editNameVC = EditNameViewController()
            editNameVC.userName = user.name
            navigationController?.pushViewController(editNameVC, animated: true)
        }
    }
}

// MARK: - PhotoTableViewCellDelegate

extension MyProfileViewController: PhotoTableViewCellDelegate {
    func didTapPhotoButton() {
//        imagePicker.sourceType = .camera
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

// MARK: - PHPickerViewControllerDelegate

extension MyProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        let itemProviders = results.map(\.itemProvider)
        if let itemProvider = itemProviders.first, itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] (image, error) in
                guard let self = self, let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    let indexPathToBeUpdated = IndexPath(row: 0, section: 0)
                    if let cell = self.tableView.cellForRow(at: indexPathToBeUpdated) as? PhotoTableViewCell {
                        cell.updatePhoto(image: image)
                    }
                }
                
                StorageManager.shared.uploadPhoto(image: image, photoName: self.user.userID) { result in
                    switch result {
                    case .success(let url):
                        StoreManager.shared.updateUserPhoto(id: self.user.userID, image: url.absoluteString)
                        print(url)
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
}
