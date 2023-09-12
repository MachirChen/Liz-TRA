//
//  TokenManager.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/19.
//

import Foundation

class TokenManager {
    static let shared = TokenManager()
    
    var accessToken = String()
    
    func getToken() {
        
        if let expirationDate = UserDefaults.standard.object(forKey: "expirationInterval") as? Date,
           expirationDate > Date() {
            self.accessToken = UserDefaults.standard.object(forKey: "token") as! String
            return
        }
        
        let url = URL(string: "https://tdx.transportdata.tw/auth/realms/TDXConnect/protocol/openid-connect/token")!
        let clientId = "machirchen-506cbd7f-855c-4d9e"
        let clientSecret = "1fe3ec62-c935-4a44-a43f-602becb0104d"
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "content-type")
        let data = "grant_type=client_credentials&client_id=\(clientId)&client_secret=\(clientSecret)".data(using: .utf8)
        request.httpBody = data
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let token = try decoder.decode(Token.self, from: data)
                    self.accessToken = token.accessToken
                    UserDefaults.standard.set(self.accessToken, forKey: "token")
                    UserDefaults.standard.set(Date(timeIntervalSinceNow: 72000), forKey: "expirationInterval")
                } catch let decoderErr {
                    print("Failed to decoder token:", decoderErr)
                }
            }
        }.resume()
    }
    
    
}
