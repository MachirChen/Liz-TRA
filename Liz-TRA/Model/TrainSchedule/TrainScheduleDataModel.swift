//
//  TrainScheduleDataModel.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/4.
//

import Foundation

struct TrainScheduleData: Codable {
    let trainDate: String
    let trainTimetables: [TrainTimetable]
}

struct TrainTimetable: Codable {
    var trainInfo: TrainInfo
    let stopTimes: [StopTime]
}

struct TrainInfo: Codable {
    let trainNo: String
    let direction: Int
    let trainTypeCode: String
    var trainTypeName: Name
    let tripHeadSign: String
    let endingStationName: Name
    let note: String
    var delayTime: Int?
}

struct StopTime: Codable {
    let stopSequence: Int
    let stationID: String
    let stationName: Name
    let arrivalTime: String
    let departureTime: String
    let suspendedFlag: Int
}

struct Name: Codable {
    var zhTw: String
    let en: String
    
    enum Name: String, CodingKey {
        case zhTw = "zh_tw"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.en = try container.decode(String.self, forKey: .en)
        let additionalContainer = try decoder.container(keyedBy: Name.self)
        self.zhTw = try additionalContainer.decode(String.self, forKey: .zhTw)
    }
}
