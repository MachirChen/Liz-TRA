//
//  TrainScheduleInquiryResultViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/8.
//

import UIKit

class TrainScheduleInquiryResultViewController: UIViewController {
    
    // MARK: - Property
    
    private var tableView = UITableView()
    private var trainScheduleData = [TrainSchedule]()
    private var trainScheduleInquiryResult: TrainScheduleData?
    private var trainSchedule: [TrainTimetable] = []
    private var fare: TrainFare?
    public var isDepartureTime: Bool!
    private var liveboard: TrainLiveBoardData?
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupActivityIndicator()
        trainScheduleData = CoreDataManager.shared.fetchTrainScheduleData()
        navigationItem.title = "\(trainScheduleData[0].departureStation!) → \(trainScheduleData[0].arrivalStation!)"
        fetchData()
    }
    
    // MARK: - Method
    
    private func fetchData() {
       
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "com.machir.queue1")
        
        group.enter()
        queue1.async(group: group) {
            TrainScheduleManager.shared.fetchTrainSchedule(departureId: self.trainScheduleData[0].departureId!, arrivalId: self.trainScheduleData[0].arrivalId!, date: self.trainScheduleData[0].date!) { result in
                switch result {
                case .success(let trainSchedule):
                    self.trainScheduleInquiryResult = trainSchedule
                    self.filter(trainSchedule.trainTimetables)
                    if trainSchedule.trainTimetables.isEmpty {
                        let subLine = CityData.subLine
                        for i in 0..<subLine.count {
                            let currentSL = subLine[i]
                            for n in 0..<currentSL.stations.count {
                                if self.trainScheduleData[0].departureId! == currentSL.stations[n].id {
                                    break
                                }
                            }
                        }
                        self.showAlert()
                        return
                    }
                    group.enter()
                    TrainScheduleManager.shared.fetchTrainFare(departureId: self.trainScheduleData[0].departureId!, arrivalId: self.trainScheduleData[0].arrivalId!, direction: trainSchedule.trainTimetables[0].trainInfo.direction) { result in
                        switch result {
                        case .success(let fare):
                            self.fare = fare
                        case .failure(_):
                            self.showAlert()
                        }
                        group.leave()
                    }
                    
                    group.enter()
                    TrainScheduleManager.shared.fetchTrainLiveBoard { liveBoard in
                        self.liveboard = liveBoard
                        self.filter(liveBoard.trainLiveBoards)
                        group.leave()
                    }
                case .failure(_):
                    self.showAlert()
                }
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
        }
        
    }
    
    private func filter(_ trainLiveBoard: [TrainLiveBoard]) {
        var liveBoardData: [TrainLiveBoard] = []
        for i in 0..<self.trainSchedule.count {
            self.trainSchedule[i].trainInfo.delayTime = 0
            let trainNo = self.trainSchedule[i].trainInfo.trainNo
            for x in 0..<trainLiveBoard.count {
                if trainNo == trainLiveBoard[x].trainNo {
                    liveBoardData.append(trainLiveBoard[x])
                    break
                }
            }
        }
        self.liveboard?.trainLiveBoards = liveBoardData
        
        guard self.liveboard?.trainLiveBoards.isEmpty == false else { return }
        for i in 0..<self.liveboard!.trainLiveBoards.count {
            let trainNo = self.liveboard?.trainLiveBoards[i].trainNo
            for n in 0..<self.trainSchedule.count {
                if self.trainSchedule[n].trainInfo.trainNo == trainNo {
                    if self.liveboard!.trainLiveBoards[i].delayTime > 0 {
                        self.trainSchedule[n].trainInfo.delayTime = self.liveboard!.trainLiveBoards[i].delayTime
                    }
                    break
                }
            }
        }
    }
    
    private func setupActivityIndicator() {
        activityIndicator.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
        activityIndicator.color = .lizOrenge
        activityIndicator.startAnimating()
        tableView.addSubview(activityIndicator)
    }
    
    private func showAlert() {
        let controller = UIAlertController(title: "", message: "無查詢結果", preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "好", style: .default))
        present(controller, animated: true)
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.hidesWhenStopped = true
        }
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height), style: .plain)
        tableView.register(TrainScheduleInquiryResultTableViewCell.self, forCellReuseIdentifier: TrainScheduleInquiryResultTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .lightGray
        view.addSubview(tableView)
    }
    
    private func travelTime(departureTime: String, arrivalTime: String) -> String {
        
        var departureInt = Int()
        var arrivalInt = Int()
        var travelTimeStr = String()
        
        if departureTime.prefix(2) == "00" {
            let minuteInt = Int(departureTime.suffix(2))!
            departureInt = (24 * 60) + minuteInt
        } else {
            let hourInt = Int(departureTime.prefix(2))! * 60
            let minuteInt = Int(departureTime.suffix(2))!
            departureInt = hourInt + minuteInt
        }
        
        if arrivalTime.prefix(2) == "00" {
            let minuteInt = Int(arrivalTime.suffix(2))!
            arrivalInt = (24 * 60) + minuteInt
        } else {
            let hourInt = Int(arrivalTime.prefix(2))! * 60
            let minuteInt = Int(arrivalTime.suffix(2))!
            arrivalInt = hourInt + minuteInt
        }
        
        let travelTime = arrivalInt - departureInt
        
        if travelTime / 60 == 0 {
            let minute = travelTime % 60
            travelTimeStr = "\(minute)分"
        } else {
            let minute = travelTime % 60
            let hour = travelTime / 60
            travelTimeStr = "\(hour)小時\(minute)分"
        }
        return travelTimeStr
        
    }
    
    private func filter(_ data: [TrainTimetable]) {
        var filterData = data
        if isDepartureTime {
            filterData = data.filter { $0.stopTimes[0].departureTime >= trainScheduleData[0].time! }
        } else {
            filterData = data.filter { $0.stopTimes.reversed()[0].arrivalTime <= trainScheduleData[0].time! }
        }
        var sort = filterData.sorted(by: { $0.stopTimes[0].departureTime < $1.stopTimes[0].departureTime })
        
        for i in 0..<sort.count {
            let trainTypeCode = TrainTypeCode(rawValue: sort[i].trainInfo.trainTypeCode)
            switch trainTypeCode {
            case .Puyuma:
                sort[i].trainInfo.trainTypeName.zhTw = "普悠瑪"
                break
            case .TzeChiang:
                sort[i].trainInfo.trainTypeName.zhTw = "自強"
                break
            case .ChuKuang:
                sort[i].trainInfo.trainTypeName.zhTw = "莒光"
                break
            case .LocalTrain:
                sort[i].trainInfo.trainTypeName.zhTw = "區間"
                break
            case .FastLocalTrain:
                sort[i].trainInfo.trainTypeName.zhTw = "區間快"
                break
            case .TzeChiang3000:
                sort[i].trainInfo.trainTypeName.zhTw = "自強(3000)"
                break
            default:
                break
            }
        }
        self.trainSchedule = sort
    }

}

// MARK: - TableViewDataSource

extension TrainScheduleInquiryResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainSchedule.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrainScheduleInquiryResultTableViewCell.identifier, for: indexPath) as? TrainScheduleInquiryResultTableViewCell else { return UITableViewCell()}
        guard let fare = fare else { return UITableViewCell() }
        
        let data = trainSchedule[indexPath.row]
        for i in 0..<fare.oDFares.count {
            if data.trainInfo.trainTypeCode == String(fare.oDFares[i].trainType) {
                cell.updateCell(data, travelTime: travelTime(departureTime: data.stopTimes[0].departureTime, arrivalTime: data.stopTimes.reversed()[0].arrivalTime), ticketPrice: String(fare.oDFares[i].fares[0].price))
                break
            }
        }
        cell.onTimeAndDelayLabel.text = "準點"
        cell.onTimeAndDelayLabel.textColor = .systemGray
        if data.trainInfo.delayTime == 0 {
            cell.onTimeAndDelayLabel.text = "準點"
        } else {
            cell.onTimeAndDelayLabel.text = "晚\(data.trainInfo.delayTime!)分"
            cell.onTimeAndDelayLabel.textColor = .systemRed
        }
        return cell
    }
}

// MARK: - TableViewDelegate

extension TrainScheduleInquiryResultViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let trainNo = trainSchedule[indexPath.row].trainInfo.trainNo
        guard let trainDate = trainScheduleInquiryResult?.trainDate else { return }
        let date = trainDate
        let controller = TrainNumberDetailViewController()
        controller.trainNo = trainNo
        controller.trainDate = date
        controller.trainType = trainSchedule[indexPath.row].trainInfo.trainTypeName.zhTw
        navigationController?.pushViewController(controller, animated: true)
    }
}

enum TrainTypeCode: String {
    case Puyuma = "2"
    case TzeChiang = "3"
    case ChuKuang = "4"
    case LocalTrain = "6"
    case FastLocalTrain = "10"
    case TzeChiang3000 = "11"
}
