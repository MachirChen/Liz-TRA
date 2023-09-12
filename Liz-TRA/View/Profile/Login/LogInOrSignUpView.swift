//
//  LogInOrSignUpView.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/30.
//

import UIKit
import SnapKit

protocol LogInOrSignUpViewDelegate: AnyObject {
    func didTapSignUp()
    func didTapLogIn()
}

class LogInOrSignUpView: UIView {
    
    weak var delegate: LogInOrSignUpViewDelegate?
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "Liz"
        label.textAlignment = .center
        label.font = UIFont(name: "Savoye LET", size: 200)
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("註冊新帳號", for: .normal)
        button.cornerRadii(radii: 5)
        button.backgroundColor = .lizBlue
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(tapSignUp), for: .touchUpInside)
        return button
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.setTitle("登入", for: .normal)
        button.cornerRadii(radii: 5)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(tapLogIn), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapSignUp() {
        delegate?.didTapSignUp()
    }
    
    @objc private func tapLogIn() {
        delegate?.didTapLogIn()
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(signUpButton)
        addSubview(logInButton)
        addSubview(logoLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        
        logoLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        logInButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalTo(40)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(logInButton.snp.top).offset(-20)
            make.leading.trailing.equalTo(logInButton)
            make.height.equalTo(40)
        }
    }
    
}
