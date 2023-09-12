//
//  Date+.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/11.
//

import Foundation

extension Date {
    
    static func getCurrentDateAndTime() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_TW")
        dateFormatter.dateFormat = "YYYY/MM/dd HH:mm"
        let string = dateFormatter.string(from: currentDate)
        return string
    }
    
    static func getCurrentDate() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_TW")
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let string = dateFormatter.string(from: currentDate)
        return string
    }
    
    static func getCurrentTime() -> String {
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_TW")
        dateFormatter.dateFormat = "HH:mm"
        let string = dateFormatter.string(from: currentDate)
        return string
    }
    
}
