//
//  DateAndTimeViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/13.
//

import UIKit

protocol DateAndTimeViewControllerDelegate: AnyObject {
    func didDismissDateAndTimeViewController()
}

class DateAndTimeViewController: UIViewController {
    
    weak var delegate: DateAndTimeViewControllerDelegate?
    private let dateAndTimeView = DateAndTimeView()
    private var date = String()
    private var time = String()
    
    override func loadView() {
        super.loadView()
        view = dateAndTimeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dateAndTimeView.delegate = self
    }
    
}

//MARK: - DateAndTimeViewDelegate

extension DateAndTimeViewController: DateAndTimeViewDelegate {
    func didTapConfirmButton() {
        dismiss(animated: true) {
            CoreDataManager.shared.editTrainSchedule(date: self.date, time: self.time)
            self.delegate?.didDismissDateAndTimeViewController()
        }
    }
    
    func didTapCancelButton() {
        dismiss(animated: true)
    }
    
    func didTapDateAndTimePicker(sender: UIDatePicker) {
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd"
        self.date = date.string(from: sender.date)
        let time = DateFormatter()
        time.dateFormat = "HH:mm"
        self.time = time.string(from: sender.date)
    }
}
