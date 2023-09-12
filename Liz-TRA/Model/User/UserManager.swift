//
//  UserManager.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/29.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FacebookLogin

//已整理完2023.09.08
//FirebaseAuth
class UserManager {
    static let shared = UserManager()
    lazy var firebaseAuth = Auth.auth()
    
    var currentUser: User? {
        Auth.auth().currentUser
    }
    
    func deleteUser() {
        //這是for google登入的刪除方式
        guard let currentUser = currentUser else { return }
        guard let providerData = currentUser.providerData.first else { return }
        
        let providerID = providerData.providerID
        print("providerID:", providerID)
        
        switch providerID {
            
        case "password":
            currentUser.delete(completion: { error in
                if let error = error {
                    print("刪除auth使用者失敗:", error)
                } else {
                    StoreManager.shared.deleteUserData(id: currentUser.uid)
                    print("email登入auth的使用者已刪出")
                }
            })
            
        case "google.com":
            guard let googleUser = GIDSignIn.sharedInstance.currentUser else { return }
            googleUser.refreshTokensIfNeeded { user, error in
                guard let user = user, let idToken = user.idToken?.tokenString else { return }
                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                currentUser.reauthenticate(with: credential) { result, error in
                    if let result = result {
                        result.user.delete { error in
                            if let error = error {
                                print("Failed to delete user:", error)
                            } else {
                                StoreManager.shared.deleteUserData(id: result.user.uid)
                                GIDSignIn.sharedInstance.signOut()
                                GIDSignIn.sharedInstance.disconnect { error in
                                    if let error = error {
                                        print("google帳號和App連結相關資料刪除失敗:", error)
                                    } else {
                                        print("google帳號和App連結相關資料刪除成功")
                                    }
                                }
                                do {
                                    try self.firebaseAuth.signOut()
                                    print("auth登出成功")
                                } catch let signOutError {
                                    print("FirebaseAuth error signing out:", signOutError)
                                }
                            }
                        }
                    }
                }
            }
            
        case "apple.com":
            currentUser.delete(completion: { error in
                if let error = error {
                    print("刪除auth使用者失敗:", error)
                } else {
                    print(currentUser.uid)
                    StoreManager.shared.deleteUserData(id: currentUser.uid)
                    print("apple登入auth的使用者已刪出")
                }
            })
            
        default:
            break
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError {
            print("FirebaseAuth error signing out:", signOutError)
        }
    }
    
    func googleSignIn(withPresenting presentingViewController: UIViewController, completion: @escaping (Result<(Account), Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { result, error in
            guard error == nil else { return }
            guard let user = result?.user, let idToken = user.idToken?.tokenString else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            self.firebaseAuth.signIn(with: credential) { result, error in
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                guard let result = result else { return }
                StoreManager.shared.fetchOrCreateUser(byID: result.user.uid, withName: result.user.displayName) { result in
                    switch result {
                    case .success(let account):
                        print("google登入，store抓資料成功")
                        completion(.success(account))
                    case .failure(let error):
                        print("google登入，store抓資料編碼或解碼失敗:", error)
                    }
                }
            }
        }
    }
    
    func appleSignIn(credential: AuthCredential, completion: @escaping (Result<Account, Error>) -> Void) {
        firebaseAuth.signIn(with: credential) { result, error in
            guard error == nil else {
                print("Apple登入auth失敗:", error!)
                completion(.failure(error!))
                return
            }
            guard let result = result else { return }
            StoreManager.shared.fetchOrCreateUser(byID: result.user.uid, withName: result.user.displayName) { result in
                switch result {
                case .success(let account):
                    print("Apple登入成功且Store抓資料成功")
                    completion(.success(account))
                case .failure(let error):
                    print("Apple登入成功但Store抓資料失敗:", error)
                }
            }
        }
    }
    
    func emailSignUp(email: String, password: String, completion: @escaping (Result<Account, Error>) -> Void) {
        firebaseAuth.createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                //註冊失敗
                print("email在auth創建失敗:", error!)
                completion(.failure(error!))
                return
            }
            guard let authResult = authResult else { return }
            StoreManager.shared.fetchOrCreateUser(byID: authResult.user.uid, withName: nil) { result in
                switch result {
                case .success(let account):
                    print("email註冊成功且創建資料完成")
                    completion(.success(account))
                case .failure(let error):
                    print("email創建auth成功，在store創建資料失敗:", error)
                }
            }
        }
    }
    
    func emailSignIn(email: String, password: String, completion: @escaping (Result<Account, Error>) -> Void) {
        firebaseAuth.signIn(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                print("email登入失敗:", error!)
                completion(.failure(error!))
                return
            }
            guard let authResult = authResult else { return }
            StoreManager.shared.fetchOrCreateUser(byID: authResult.user.uid, withName: nil) { result in
                switch result {
                case .success(let account):
                    print("email登入成功且抓資料完成")
                    completion(.success(account))
                case .failure(let error):
                    print("email登入auth成功，在store獲取資料失敗:", error)
                }
            }
        }
    }
    
    
    func facebookSingUp(withPresenting presentingViewController: UIViewController, completion: @escaping (Result<(), Error>) -> Void) {
        let manager = LoginManager()
        manager.logIn(permissions: [.publicProfile, .email], viewController: nil) { result in
            switch result {
            case .success(granted: let granted, declined: let declined, token: let token):
                print("success", granted, declined, token)
            case .cancelled:
                print("cancelled")
            case .failed(_):
                print("failed")
            }
        }
    }
    
}
