//
//  SignUpViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/30.
//

import UIKit
import AuthenticationServices
import FirebaseAuth
import CryptoKit
//這個controller已整理完2023.09.08
class SignUpViewController: UIViewController {
    
    private let signUpView = SignUpView()
    fileprivate var currentNonce: String?
    
    override func loadView() {
        super.loadView()
        view = signUpView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        signUpView.delegate = self
        navigationItem.title = "註冊新帳號"
    }
    
}

extension SignUpViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        self.view.window!
    }
}

extension SignUpViewController: ASAuthorizationControllerDelegate {
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

extension SignUpViewController: SignUpViewDelegate {
    func didTapGoogleSignUp() {
        UserManager.shared.googleSignIn(withPresenting: self) { result in
            switch result {
            case .success(_):
                self.dismiss(animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func didTapFacebookSignUp() {
        UserManager.shared.facebookSingUp(withPresenting: self) { result in
            switch result {
            case .success(_):
                print("facebook登入成功且已上傳資料到firebase")
            case .failure(_):
                print("facebook註冊失敗")
            }
        }
    }
    
    func didTapAppleSignUp() {
        startSignInWithAppleFlow()
    }
    
    func didTapEmailSignUp() {
        let emailSignUpVC = EmailLogInViewController()
        emailSignUpVC.isSignUp = true
        navigationController?.pushViewController(emailSignUpVC, animated: true)
    }
}

extension SignUpViewController {

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
