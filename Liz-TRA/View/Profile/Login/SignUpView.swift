//
//  SignUpView.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/30.
//

import UIKit

protocol SignUpViewDelegate: AnyObject {
    func didTapGoogleSignUp()
    func didTapFacebookSignUp()
    func didTapAppleSignUp()
    func didTapEmailSignUp()
}

class SignUpView: UIView {
//修改這個view顏色開始
    weak var delegate: SignUpViewDelegate?
    
    private lazy var googleButton: UIButton = {
        let button = UIButton()
        button.setTitle("使用 Google 註冊", for: .normal)
        button.setImage(UIImage(named: "Google"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tapGoogleSignUp), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.cornerRadii(radii: 20)
        return button
    }()
    
    private lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setTitle("使用 Facebook 註冊", for: .normal)
        button.setImage(UIImage(named: "Google"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tapFacebookSignUp), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private lazy var appleButton: UIButton = {
        let button = UIButton()
        button.setTitle("使用 Apple 註冊", for: .normal)
        button.setImage(UIImage(named: "apple"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tapAppleSignUp), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.cornerRadii(radii: 20)
        return button
    }()
    
    private lazy var emailButton: UIButton = {
        let button = UIButton()
        button.setTitle("使用 Email 註冊", for: .normal)
        button.setImage(UIImage(named: "email"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(tapEmailSignUp), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.cornerRadii(radii: 20)
        return button
    }()
    
    @objc private func tapGoogleSignUp() {
        delegate?.didTapGoogleSignUp()
    }
    
    @objc private func tapFacebookSignUp() {
        delegate?.didTapFacebookSignUp()
    }
    
    @objc private func tapAppleSignUp() {
        delegate?.didTapAppleSignUp()
    }
    
    @objc private func tapEmailSignUp() {
        delegate?.didTapEmailSignUp()
    }
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lizBlue
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
    }
    
}
