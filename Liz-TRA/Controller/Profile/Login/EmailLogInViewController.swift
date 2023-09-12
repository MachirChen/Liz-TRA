//
//  EmailLogInViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/9/4.
//

import UIKit
//這個controller已整理完2023.09.08
class EmailLogInViewController: UIViewController {
    
    private let emailLogInView = EmailLogInView()
    private var email = String()
    private var password = String()
    public var isSignUp: Bool!
    
    override func loadView() {
        super.loadView()
        view = emailLogInView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        if isSignUp {
            title = "使用Email註冊"
            emailLogInView.updateEmailLogInView(setButtonTitle: "註冊")
        } else {
            title = "使用Email登入"
            emailLogInView.updateEmailLogInView(setButtonTitle: "登入")
        }
        setupEmailLoginView()
    }
    
    private func setupEmailLoginView() {
        emailLogInView.delegate = self
        emailLogInView.emailTextField.delegate = self
        emailLogInView.passwordTextField.delegate = self
    }

    private func showFailedAlert(title: String, message: String) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "好", style: .default))
        present(controller, animated: true)
    }

}

extension EmailLogInViewController: EmailLogInViewDelegate {
    func didTapSignIn() {
        if isSignUp {
            UserManager.shared.emailSignUp(email: email, password: password) { result in
                switch result {
                case .success(_):
                    self.dismiss(animated: true)
                case .failure(_):
                    self.showFailedAlert(title: "註冊失敗", message: "")
                }
            }
        } else {
            UserManager.shared.emailSignIn(email: email, password: password) { result in
                switch result {
                case.success(_):
                    self.dismiss(animated: true)
                case.failure(_):
                    self.showFailedAlert(title: "登入失敗", message: "找不到此會員")
                }
            }
        }
    }
}

extension EmailLogInViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text, let textRange = Range(range, in: text) else { return true }
        let updatedText = text.replacingCharacters(in: textRange, with: string)
        
        if textField == emailLogInView.emailTextField {
            email = updatedText
        } else if textField == emailLogInView.passwordTextField {
            password = updatedText
        }
        
        if isValidEmail(email) && password.count > 5 {
            emailLogInView.updateSignInButton(enabled: true, backgroundColor: .lizBlue)
        } else {
            emailLogInView.updateSignInButton(enabled: false, backgroundColor: .secondarySystemBackground)
        }
        
        return true
    }
    
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
