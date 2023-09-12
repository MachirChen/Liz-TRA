//
//  HomeViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/6.
//

import UIKit
import CoreData

class HomeViewController: UIViewController {
    
    // MARK: - Property
    
    private let trainScheduleInquiryView = TrainScheduleInquiryView()
    private var trainScheduleData = [TrainSchedule]()
    private var isDepartureTime = true

    // MARK: - life Cycle
    
    override func loadView() {
        super.loadView()
        view = trainScheduleInquiryView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "火車時刻表"
        setupTrainScheduleInquiryView()
        fetchCurrentTime()
        fetchData()
    }
    
    
    // MARK: - Method
    
    private func fetchData() {
        
        trainScheduleData = CoreDataManager.shared.fetchTrainScheduleData()
        
        DispatchQueue.main.async {
            self.trainScheduleInquiryView.updateView(departure: self.trainScheduleData[0].departureStation!, arrival: self.trainScheduleData[0].arrivalStation!, dateAndTime: self.changeDateFormat())
        }
    }
    
    private func fetchCurrentTime() {
        CoreDataManager.shared.editTrainSchedule(date: Date.getCurrentDate(), time: Date.getCurrentTime())
    }
    
    private func changeDateFormat() -> String {
        let dateStr = trainScheduleData[0].date!.replacingOccurrences(of: "-", with: "/")
        let timeStr = trainScheduleData[0].time!
        let str = "\(dateStr) \(timeStr)"
        return str
    }

    private func setupTrainScheduleInquiryView() {
        trainScheduleInquiryView.delegate = self
    }
    
    private func presentStationSelectionVC(isDeparture: Bool) {
        let stationSelectionVC = StationSelectionViewController()
        let naviVC = UINavigationController(rootViewController: stationSelectionVC)
        stationSelectionVC.delegate = self
        stationSelectionVC.isDepartureStation = isDeparture
        present(naviVC, animated: true)
    }
    
}


// MARK: - TrainScheduleInquiryViewDelegate

extension HomeViewController: TrainScheduleInquiryViewDelegate {
    func didTapByDepartureTimeAndByArrivalTimeSegment(sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1 {
            isDepartureTime = false
        } else {
            isDepartureTime = true
        }
    }
    
    func didTapCurrentButton() {
        fetchCurrentTime()
        fetchData()
    }
    
    func didTapDateButton() {
        let dateAndTimeVC = DateAndTimeViewController()
        dateAndTimeVC.delegate = self
        present(dateAndTimeVC, animated: true)
    }
    
    func didTapExchangButton() {
        CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].arrivalStation!, departureId: trainScheduleData[0].arrivalId!, arrivalStation: trainScheduleData[0].departureStation!, arrivalId: trainScheduleData[0].departureId!)
        fetchData()
    }
    
    func didTapArrivalStationButton() {
        presentStationSelectionVC(isDeparture: false)
    }
    
    func didTapDepartureStationButton() {
        presentStationSelectionVC(isDeparture: true)
    }
    
    func didTapInquireButton() {
        let resultController = TrainScheduleInquiryResultViewController()
        resultController.isDepartureTime = isDepartureTime
        resultController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(resultController, animated: true)
    }
}

// MARK: - StationSelectionViewControllerDelegate

extension HomeViewController: StationSelectionViewControllerDelegate {
    func didDismissStationSelectionViewController() {
        fetchData()
    }
}

//MARK: - DateAndTimeViewControllerDelegate

extension HomeViewController: DateAndTimeViewControllerDelegate {
    func didDismissDateAndTimeViewController() {
        fetchData()
    }
}

