//
//  TokenDataModel.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/19.
//

import Foundation

struct Token: Codable {
    let accessToken: String
    
    enum TokenKey: String, CodingKey {
        case accessToken = "access_token"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TokenKey.self)
        self.accessToken = try container.decode(String.self, forKey: .accessToken)
    }
}
