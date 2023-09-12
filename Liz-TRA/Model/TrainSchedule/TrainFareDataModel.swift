//
//  TrainFareDataModel.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/10.
//

import Foundation

struct TrainFare: Codable {
    let oDFares: [ODFare]
}

struct ODFare: Codable {
    let originStationID: String
    let destinationStationID: String
    let direction: Int
    let trainType: Int
    let fares: [Fare]
    let travelDistance: Double
}

struct Fare: Codable {
    let ticketType: Int
    let fareClass: Int
    let cabinClass: Int
    let price: Int
}
