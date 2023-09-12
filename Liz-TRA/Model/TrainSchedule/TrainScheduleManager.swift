//
//  TrainScheduleManager.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/11.
//

import Foundation

class TrainScheduleManager {
    static let shared = TrainScheduleManager()
    
    lazy var trainSchedule = [TrainSchedule]()
    
    func getTrainSchedule() {
        trainSchedule =  CoreDataManager.shared.fetchTrainScheduleData()
    }
    
    func fetchTrainSchedule(departureId: String, arrivalId: String, date: String, completion: @escaping (Result<TrainScheduleData, Error>) -> Void) {
        let url = URL(string: "https://tdx.transportdata.tw/api/basic/v3/Rail/TRA/DailyTrainTimetable/OD/Inclusive/\(departureId)/to/\(arrivalId)/\(date)?%24format=JSON")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .bigCaseToSmall
                do {
                    let trainScheduleData = try decoder.decode(TrainScheduleData.self, from: data)
                    completion(.success(trainScheduleData))
                } catch let err {
                    print("Failed to decoder trainScheduleData:", err)
                }
            }
        }.resume()
    }
    
    func fetchTrainFare(departureId: String, arrivalId: String, direction: Int, completion: @escaping (Result<TrainFare, Error>) -> Void) {
        let url = URL(string: "https://tdx.transportdata.tw/api/basic/v3/Rail/TRA/ODFare/\(departureId)/to/\(arrivalId)?%24filter=Direction%20eq%20%27\(direction)%27&%24format=JSON")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .bigCaseToSmall
                do {
                    let fare = try decoder.decode(TrainFare.self, from: data)
                    completion(.success(fare))
                } catch let err {
                    print("Failed to decoder train fare:", err)
                }
            }
        }.resume()
    }
    
    func fetchTrainLiveBoard(completion: @escaping (TrainLiveBoardData) -> Void) {
        let url = URL(string: "https://tdx.transportdata.tw/api/basic/v3/Rail/TRA/TrainLiveBoard?%24format=JSON")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .bigCaseToSmall
                do {
                    let liveBoard = try decoder.decode(TrainLiveBoardData.self, from: data)
                    completion(liveBoard)
                } catch let err {
                    print("Failed to decoder train live board:", err)
                }
            }
        }.resume()
    }
    
    func fetchTrainNoDetail(_ trainNo: String, _ date: String, completion: @escaping (Result<TrainNo, Error>) -> Void) {
        let url = URL(string: "https://tdx.transportdata.tw/api/basic/v2/Rail/TRA/DailyTimetable/TrainNo/\(trainNo)/TrainDate/\(date)?%24format=JSON")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .bigCaseToSmall
                do {
                    let detail = try decoder.decode([TrainNo].self, from: data)
                    let data = detail[0]
                    completion(.success(data))
                    print(detail)
                } catch let err {
                    completion(.failure(err))
                    print("Failed to decoder train no detail:", err)
                }
            }
        }.resume()
    }
    
    func fetchTrainArrivalAndDepartureInfo(_ trainNo: String, completion: @escaping ([StationLiveBoard]) -> Void) {
        let url = URL(string: "https://tdx.transportdata.tw/api/basic/v2/Rail/TRA/LiveBoard?%24filter=TrainNo%20eq%20%27\(trainNo)%27&%24top=5&%24format=JSON")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .bigCaseToSmall
                do {
                    let data = try decoder.decode([StationLiveBoard].self, from: data)
                    completion(data)
                    print(data)
                } catch let err {
                    print(err)
                }
            }
        }.resume()
    }
    
    func fetchStationSchedule(stationID: String, completion: @escaping ([StationSchedule]?) -> Void ) {
        let url = URL(string: "https://tdx.transportdata.tw/api/basic/v2/Rail/TRA/DailyTimetable/Station/\(stationID)/2023-08-23?%24orderby=DepartureTime&%24format=JSON")!
        var request = URLRequest(url: url)
        request.setValue("Bearer \(TokenManager.shared.accessToken)", forHTTPHeaderField: "authorization")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .bigCaseToSmall
                do {
                    let data = try decoder.decode([StationSchedule].self, from: data)
                    completion(data)
                } catch let err {
                    print(err)
                    completion(nil)
                }
            }
        }.resume()
    }
    
}

