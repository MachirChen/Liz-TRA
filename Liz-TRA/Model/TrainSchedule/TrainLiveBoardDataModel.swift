//
//  TrainLiveBoardDataModel.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/11.
//

import Foundation

struct TrainLiveBoardData: Codable {
    var trainLiveBoards: [TrainLiveBoard]
}

struct TrainLiveBoard: Codable {
    let trainNo: String
    let stationID: String
    let stationName: Name
    let trainStationStatus: Int
    let delayTime: Int
}
