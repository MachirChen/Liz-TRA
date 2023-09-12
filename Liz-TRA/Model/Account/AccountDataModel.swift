//
//  AccountDataModel.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/25.
//

import Foundation

struct Account: Codable {
    var userID: String
    var name: String
    var image: String = "https://firebasestorage.googleapis.com/v0/b/liz-tra.appspot.com/o/Liz-Logo.png?alt=media&token=876b12a4-2b42-4ea9-a4e0-bdc092233754"
}
