//
//  StoreManager.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/29.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift
//已整理完2023.09.08
class StoreManager {
    
    static let shared = StoreManager()
    lazy var db = Firestore.firestore()
    
    func updateUserPhoto(id: String, image: String) {
        db.collection("users").document(id).updateData(["image" : image])
    }
    
    func updateUserName(id: String, name: String) {
        db.collection("users").document(id).updateData(["name" : name])
    }
    
    func listenUserData(id: String, completion: @escaping (Account) -> Void) -> ListenerRegistration {
        return db.collection("users").document(id).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            let source = document.metadata.hasPendingWrites ? "Local" : "Server"
            print("\(source) data: \(document.data() ?? [:])")
            do {
                let account = try document.data(as: Account.self)
                completion(account)
            } catch let err {
                print("Failed to decoder account:", err)
            }
        }
    }
    
    func fetchOrCreateUser(byID id: String, withName name: String?, completion: @escaping (Result<Account, Error>) -> Void ) {
        
        db.collection("users").document(id).getDocument { document, error in
            if let document = document, document.exists {
                do {
                    let account = try document.data(as: Account.self)
                    completion(.success(account))
                } catch {
                    print("decoder失敗:", error)
                    completion(.failure(error))
                }
            } else {
                //並未在store抓到資料，在此創建新的
                do {
                    let account = Account(userID: id, name: name ?? "匿名")
                    try self.db.collection("users").document(id).setData(from: account)
                    completion(.success(account))
                } catch {
                    print("編碼上傳失敗：", error)
                    completion(.failure(error))
                }
            }
        }
        
    }
    
    func deleteUserData(id: String) {
        db.collection("users").document(id).delete { error in
            if let error = error {
                print("store資料刪除失敗:", error)
            } else {
                print("store資料刪除成功")
            }
        }
    }
}
