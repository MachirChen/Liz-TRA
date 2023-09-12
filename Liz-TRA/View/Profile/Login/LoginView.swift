//
//  LoginView.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/24.
//

import UIKit
import SnapKit
import GoogleSignIn

protocol LoginViewDelegate: AnyObject {
    func didTapGoogleSignIn()
    func didTapFacebookSignIn()
    func didTapAppleSignIn()
    func didTapEmailSignIn()
}

class LoginView: UIView {
    
    weak var delegate: LoginViewDelegate?
    
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setTitle("使用 Google 登入", for: .normal)
        button.setImage(UIImage(named: "Google"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tapGoogleSignIn), for: .touchUpInside)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.cornerRadii(radii: 20)
        return button
    }()
    
    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setTitle("使用 Facebook 登入", for: .normal)
        button.setImage(UIImage(named: "Google"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tapFacebookSignIn), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setTitle("使用 Apple 登入", for: .normal)
        button.setImage(UIImage(named: "apple"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tapAppleSignIn), for: .touchUpInside)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.cornerRadii(radii: 20)
        return button
    }()
    
    private lazy var emailButton: UIButton = {
        let button = UIButton()
        button.setTitle("使用 Email 登入", for: .normal)
        button.setImage(UIImage(named: "email"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tapEmailSignIn), for: .touchUpInside)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.cornerRadii(radii: 20)
        return button
    }()
    
//    lazy var googleSignInButton: GIDSignInButton = {
//        let button = GIDSignInButton()
//        button.style = .wide
//        button.addTarget(self, action: #selector(handleSingInButton), for: .touchUpInside)
//        return button
//    }()
    
    @objc private func tapGoogleSignIn() {
        delegate?.didTapGoogleSignIn()
    }
    
    @objc private func tapFacebookSignIn() {
        delegate?.didTapFacebookSignIn()
    }
    
    @objc private func tapAppleSignIn() {
        delegate?.didTapAppleSignIn()
    }
    
    @objc private func tapEmailSignIn() {
        delegate?.didTapEmailSignIn()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(googleButton)
//        addSubview(facebookButton)
        addSubview(appleButton)
        addSubview(emailButton)
//        addSubview(googleSignInButton)
        setupLayout()
    }
    
    private func setupLayout() {
        googleButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
            make.top.equalTo(self.safeAreaLayoutGuide).offset(80)
        }
        
//        facebookButton.snp.makeConstraints { make in
//            make.leading.trailing.height.equalTo(googleButton)
//            make.top.equalTo(googleButton.snp.bottom).offset(20)
//        }
        
        appleButton.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(googleButton)
            make.top.equalTo(googleButton.snp.bottom).offset(20)
        }
        
        emailButton.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(googleButton)
            make.top.equalTo(appleButton.snp.bottom).offset(20)
        }
        
//        googleSignInButton.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(20)
//            make.trailing.equalToSuperview().offset(-20)
//            make.top.equalToSuperview().offset(100)
//        }
    }
    
}
