//
//  StationScheduleDataModel.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/23.
//

import Foundation

struct StationSchedule: Codable {
    let trainDate: String
    let stationID: String
    let stationName: Name
    let trainNo: String
    let direction: Int
    let tripLine: Int
    let trainTypeID: String
    let trainTypeCode: String
    let trainTypeName: Name
    let startingStationID: String
    let startingStationName: Name
    let endingStationID: String
    let endingStationName: Name
    let arrivalTime: String
    let departureTime: String
    let suspendedFlag: Int
    let updateTime: String
    let versionID: Int
}
