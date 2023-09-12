//
//  JSONDecoder+.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/4.
//

import Foundation

extension JSONDecoder.KeyDecodingStrategy {
    struct BigCaseToSmallCodingKey: CodingKey {
        var stringValue: String
        
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    static var bigCaseToSmall: Self {
        .custom { codingPath in
            let lastComponent = codingPath.last!.stringValue
            let key = lastComponent.prefix(1).lowercased() + lastComponent.dropFirst()
            return BigCaseToSmallCodingKey(stringValue: key)!
        }
    }
}
