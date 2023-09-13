//
//  TrainNumberDetailViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/22.
//

import UIKit

class TrainNumberDetailViewController: UIViewController {

    public var trainNo: String!
    public var trainDate: String!
    public var trainType: String!
    private let tableView = UITableView()
    private var trainNoDetail: TrainNo?
    private var trainOnTimeAndDelayTimeInfo: [StationLiveBoard]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNaviItem()
        setupTableView()
        fetchData()
    }
    
    private func setupNaviItem() {
        if let trainDate = trainDate, let trainNo = trainNo, let trainType = trainType {
            let date = String(trainDate.suffix(5)).replacingOccurrences(of: "-", with: "/")
            navigationItem.title = "\(date) \(trainNo)次 \(trainType)"
        }
    }
    
    private func fetchData() {
        
        let group = DispatchGroup()
        let queue1 = DispatchQueue(label: "com.machir.queue1")
        let queue2 = DispatchQueue(label: "com.machir.queue2")
        
        group.enter()
        queue1.async(group: group) {
            TrainScheduleManager.shared.fetchTrainNoDetail(self.trainNo, self.trainDate) { result in
                switch result {
                case .success(let data):
                    self.trainNoDetail = data
                case .failure(_):
                    print("TrainNumberDetailViewController: 錯誤")
                }
                group.leave()
            }
        }
        
        group.enter()
        queue2.async(group: group) {
            TrainScheduleManager.shared.fetchTrainArrivalAndDepartureInfo(self.trainNo) { data in
                self.trainOnTimeAndDelayTimeInfo = data
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.frame = CGRect(x: 0, y: 0, width: UIScreen.width, height: UIScreen.height)
        tableView.dataSource = self
        tableView.separatorColor = .separator
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
        tableView.register(TrainNumberDetailTableViewCell.self, forCellReuseIdentifier: TrainNumberDetailTableViewCell.identifier)
        view.addSubview(tableView)
    }
    

}

extension TrainNumberDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let number = trainNoDetail?.stopTimes.count else { return 0 }
        return number
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TrainNumberDetailTableViewCell.identifier, for: indexPath) as? TrainNumberDetailTableViewCell else { return UITableViewCell() }
        guard let trainNoDetail = trainNoDetail else { return UITableViewCell() }
        guard let trainOnTimeAndDelayTimeInfo = trainOnTimeAndDelayTimeInfo else { return UITableViewCell() }
        let stopTime = trainNoDetail.stopTimes[indexPath.row]
        var delayTimeStr = String()
        if !trainOnTimeAndDelayTimeInfo.isEmpty, trainOnTimeAndDelayTimeInfo[0].stationID == stopTime.stationID {
            let delayTime = trainOnTimeAndDelayTimeInfo[0].delayTime
            if delayTime == 0 {
                delayTimeStr = "準點"
            } else if delayTime > 0 {
                delayTimeStr = "晚\(delayTime)分"
                cell.nextStation.textColor = .systemRed
            }
        }
        cell.updateCell(stopTime, delayTimeStr)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = TrainNumberDetailSectionHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.width, height: 50))
        return view
    }
    
}

