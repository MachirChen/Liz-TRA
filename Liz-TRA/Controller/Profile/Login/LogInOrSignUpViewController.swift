//
//  LogInOrSignUpViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/30.
//

import UIKit
//這個controller已整理完2023.09.08
class LogInOrSignUpViewController: UIViewController {
    
    private let logInOrSignView = LogInOrSignUpView()
    
    override func loadView() {
        super.loadView()
        view = logInOrSignView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        logInOrSignView.delegate = self
    }
    
}

extension LogInOrSignUpViewController: LogInOrSignUpViewDelegate {
    func didTapSignUp() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func didTapLogIn() {
        let logInVC = LoginViewController()
        navigationController?.pushViewController(logInVC, animated: true)
    }
}
