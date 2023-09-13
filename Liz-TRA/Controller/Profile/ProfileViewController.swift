//
//  ProfileViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/23.
//

import UIKit
import SnapKit

//這個controller已整理完2023.09.08。
class ProfileViewController: UIViewController {
    
    // MARK: - Property
    
    private let headerView = ProfileHeaderView()
    private var bodyCollectionView: UICollectionView!
    private var currentAccount: Account?
    
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        setupHeaderView()
        setupCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(updateView(noti:)), name: NSNotification.Name("updateView"), object: nil)
    }
    
    // MARK: - Method
    
    @objc private func updateView(noti: Notification) {
        if let user = noti.userInfo?["userInfoKey"] as? Account {
            self.currentAccount = user
            let imageURL = URL(string: user.image)!
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.headerView.updateProfileHV(photo: image, name: user.name)
                    }
                } else {
                    DispatchQueue.main.async {
                        self.headerView.updateProfileHV(name: user.name)
                    }
                }
            }.resume()
        }
    }
    
    private func fetchData() {
        UserManager.shared.firebaseAuth.addStateDidChangeListener { auth, user in
            if let user {
                print("登入")
                MJGProgressHUD.show()
                StoreManager.shared.fetchOrCreateUser(byID: user.uid, withName: nil) { result in
                    switch result {
                    case .success(let account):
                        self.currentAccount = account
                        let imageURL = URL(string: account.image)!
                        URLSession.shared.dataTask(with: imageURL) { data, response, error in
                            if let data = data, let image = UIImage(data: data) {
                                DispatchQueue.main.async {
                                    self.headerView.updateProfileHV(photo: image, name: account.name)
                                    MJGProgressHUD.dismiss()
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.headerView.updateProfileHV(name: account.name)
                                    MJGProgressHUD.dismiss()
                                }
                            }
                        }.resume()
                    case .failure(let error):
                        print(error)
                        //解碼失敗，可以給預設account之類的？
                    }
                }
            } else {
                MJGProgressHUD.show()
                DispatchQueue.main.async {
                    self.headerView.updateProfileHV(photo: UIImage(named: "Liz-Logo")!, name: "尚未登入")
                    MJGProgressHUD.dismiss()
                }
            }
        }
    }
    
    private func setupCollectionView() {
        bodyCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        bodyCollectionView.register(BodyCollectionViewCell.self, forCellWithReuseIdentifier: BodyCollectionViewCell.identifer)
        view.addSubview(bodyCollectionView)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width - 40, height: 40)
        layout.sectionInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        
        bodyCollectionView.collectionViewLayout = layout
        bodyCollectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        bodyCollectionView.dataSource = self
        bodyCollectionView.backgroundColor = .systemBackground
    }
    
    private func setupHeaderView() {
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(100)
        }
        headerView.delegate = self
    }

}

// MARK: - UICollectionViewDataSource

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BodyCollectionViewCell.identifer, for: indexPath) as? BodyCollectionViewCell else { return UICollectionViewCell() }
        cell.delegate = self
        return cell
    }
    
}

// MARK: - ProfileHeaderViewDelegate

extension ProfileViewController: ProfileHeaderViewDelegate {
    func didTapLoginButton() {
        if UserManager.shared.currentUser != nil {
            guard let userData = currentAccount else { return }
            let myProfileVC = MyProfileViewController()
            myProfileVC.user = userData
            let naviVC = UINavigationController(rootViewController: myProfileVC)
            present(naviVC, animated: true)
        } else {
            let logInOrSignUpVC = LogInOrSignUpViewController()
            let naviVC = UINavigationController(rootViewController: logInOrSignUpVC)
            present(naviVC, animated: true)
        }
    }
}

// MARK: - BodyCollectionViewCellDelegate

extension ProfileViewController: BodyCollectionViewCellDelegate {
    func didTapButton() {
        let settingVC = SettingViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }
}
