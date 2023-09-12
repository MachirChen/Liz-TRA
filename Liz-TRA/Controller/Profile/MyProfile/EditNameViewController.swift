//
//  EditNameViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/27.
//

import UIKit
//這個controller已整理完2023.09.08
class EditNameViewController: UIViewController {
    
    private let editNameView = EditNameView()
    public var userName: String?
    
    override func loadView() {
        super.loadView()
        self.view = editNameView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupEditNameView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(handleCancel))
    }
    
    private func setupEditNameView() {
        editNameView.nameTextField.delegate = self
        editNameView.delegate = self
        guard let userName = userName else { return }
        editNameView.updateNameTextField(text: userName)
    }
    
    @objc private func handleCancel() {
        self.dismiss(animated: true)
    }
    
}

extension EditNameViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text, let textRange = Range(range, in: text) else { return true }
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        userName = updatedText
        
        if userName == "" {
            editNameView.updateSaveButton(enabled: false, backgroundColor: .tertiarySystemFill, titleColor: .tertiaryLabel)
        } else {
            editNameView.updateSaveButton(enabled: true, backgroundColor: .lizBlue, titleColor: .label)
        }
        
        return true
    }
    
}

extension EditNameViewController: EditNameViewDelegate {
    func didTapSaveButton() {
        guard let user = UserManager.shared.currentUser else { return }
        StoreManager.shared.updateUserName(id: user.uid, name: userName!)
        navigationController?.popViewController(animated: true)
    }
}
