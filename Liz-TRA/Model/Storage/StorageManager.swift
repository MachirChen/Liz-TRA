//
//  StorageManager.swift
//  Liz-TRA
//
//  Created by Machir on 2023/9/6.
//

import Foundation
import FirebaseStorage

class StorageManager {
    
    static let shared = StorageManager()

    func uploadPhoto(image: UIImage, photoName userID: String, completion: @escaping (Result<URL, Error>) -> Void) {
        let fileReference = Storage.storage().reference().child("userImage/userID-\(userID).png")
        if let data = image.pngData() {
            fileReference.putData(data) { result in
                switch result {
                case .success:
                    fileReference.downloadURL(completion: completion)
                    print("downloadURL成功")
                case .failure(let error):
                    completion(.failure(error))
                    print("downloadURL失敗")
                }
            }
        }
    }
}
