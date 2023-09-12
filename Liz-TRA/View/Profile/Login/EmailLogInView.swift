//
//  EmailLogInView.swift
//  Liz-TRA
//
//  Created by Machir on 2023/9/4.
//

import UIKit
import SnapKit

protocol EmailLogInViewDelegate: AnyObject {
    func didTapSignIn()
}

class EmailLogInView: UIView {
    
    weak var delegate: EmailLogInViewDelegate?
    
    public let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "   常用信箱（Gmail、Yahoo 等）"
        textField.backgroundColor = .tertiarySystemFill
        textField.cornerRadii(radii: 10)
        return textField
    }()

    public let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "   密碼  (6～50 個字元)"
        textField.backgroundColor = .tertiarySystemFill
        textField.cornerRadii(radii: 10)
        textField.isSecureTextEntry = true
        return textField
    }()
    
    public lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("登入", for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(tapSignIn), for: .touchUpInside)
        button.backgroundColor = .secondarySystemBackground
        button.cornerRadii(radii: 10)
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    
    @objc private func tapSignIn() {
        delegate?.didTapSignIn()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateEmailLogInView(setButtonTitle: String) {
        signInButton.setTitle(setButtonTitle, for: .normal)
    }
    
    public func updateSignInButton(enabled: Bool, backgroundColor: UIColor) {
        signInButton.isEnabled = enabled
        signInButton.backgroundColor = backgroundColor
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(signInButton)
        setupLayout()
    }
    
    private func setupLayout() {
        emailTextField.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(80)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(emailTextField)
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(emailTextField)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
        }
    }
}
