//
//  StationLiveBoardDataModel.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/22.
//

import Foundation

struct StationLiveBoard: Codable {
    let stationID: String
    let stationName: Name
    let trainNo: String
    let direction: Int
    let trainTypeID: String
    let trainTypeCode: String
    let trainTypeName: Name
    let endingStationID: String
    let endingStationName: Name
    let tripLine: Int
    let delayTime: Int
    let scheduledArrivalTime: String
    let scheduledDepartureTime: String
}

//[
//  {
//    "StationID": "3390",
//    "StationName": {
//      "Zh_tw": "員林",
//      "En": "Yuanlin"
//    },
//    "TrainNo": "115",
//    "Direction": 1,
//    "TrainTypeID": "1109",
//    "TrainTypeCode": "3",
//    "TrainTypeName": {
//      "Zh_tw": "自強(推拉式自強號且無自行車車廂)",
//      "En": "Tze-Chiang Limited Express"
//    },
//    "TripLine": 1,
//    "EndingStationID": "5000",
//    "EndingStationName": {
//      "Zh_tw": "屏東",
//      "En": "Pingtung"
//    },
//    "ScheduledArrivalTime": "11:47:00",
//    "ScheduledDepartureTime": "11:48:00",
//    "DelayTime": 3,
//    "SrcUpdateTime": "2023-08-23T11:43:28+08:00",
//    "UpdateTime": "2023-08-23T11:44:28+08:00"
//  },
//  {
//    "StationID": "3420",
//    "StationName": {
//      "Zh_tw": "田中",
//      "En": "Tianzhong"
//    },
//    "TrainNo": "115",
//    "Direction": 1,
//    "TrainTypeID": "1109",
//    "TrainTypeCode": "3",
//    "TrainTypeName": {
//      "Zh_tw": "自強(推拉式自強號且無自行車車廂)",
//      "En": "Tze-Chiang Limited Express"
//    },
//    "TripLine": 1,
//    "EndingStationID": "5000",
//    "EndingStationName": {
//      "Zh_tw": "屏東",
//      "En": "Pingtung"
//    },
//    "ScheduledArrivalTime": "11:56:00",
//    "ScheduledDepartureTime": "11:58:00",
//    "DelayTime": 3,
//    "SrcUpdateTime": "2023-08-23T11:43:28+08:00",
//    "UpdateTime": "2023-08-23T11:44:28+08:00"
//  }
//]
