//
//  LoginViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/24.
//

import UIKit
import FirebaseAuth
import FacebookCore
import AuthenticationServices
//這個controller已整理完2023.09.08
class LoginViewController: UIViewController {
    
    private let loginView = LoginView()
    fileprivate var currentNonce: String?
    
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "登入"
        loginView.delegate = self
        //fb登入token
        if let token = AccessToken.current, !token.isExpired {
            print("FB用戶已登入")
        }
    }
    
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent.")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }

            let credential = OAuthProvider.appleCredential(withIDToken: idTokenString, rawNonce: nonce, fullName: appleIDCredential.fullName)
            
            UserManager.shared.appleSignIn(credential: credential) { result in
                switch result {
                case .success(_):
                    self.dismiss(animated: true)
                case .failure(let error):
                    print("Failed apple sign in", error)
                }
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("Sign in with Apple errored: \(error)")
    }
}

extension LoginViewController: LoginViewDelegate {
    func didTapGoogleSignIn() {
        UserManager.shared.googleSignIn(withPresenting: self) { result in
            switch result {
            case .success(_):
                self.dismiss(animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapFacebookSignIn() {
        print("tapFacebook")
    }
    
    func didTapAppleSignIn() {
        startSignInWithAppleFlow()
    }
    
    func didTapEmailSignIn() {
        let emailSignInVC = EmailLogInViewController()
        emailSignInVC.isSignUp = false
        navigationController?.pushViewController(emailSignInVC, animated: true)
    }
}

extension LoginViewController {

    func startSignInWithAppleFlow() {
        let nonce = String.randomNonceString()
        currentNonce = nonce
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = String.sha256(nonce)

        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
}


