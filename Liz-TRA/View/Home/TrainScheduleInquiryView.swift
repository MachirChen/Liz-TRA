//
//  trainTimetableSearchView.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/6.
//

import UIKit

protocol TrainScheduleInquiryViewDelegate: AnyObject {
    func didTapInquireButton()
    func didTapDepartureStationButton()
    func didTapArrivalStationButton()
    func didTapExchangButton()
    func didTapDateButton()
    func didTapCurrentButton()
    func didTapByDepartureTimeAndByArrivalTimeSegment(sender: UISegmentedControl)
}

class TrainScheduleInquiryView: UIView {
    
    weak var delegate: TrainScheduleInquiryViewDelegate?
    
    let departureStationLabel: UILabel = {
        let label = UILabel()
        label.text = "出發"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .lizOrenge
        label.textAlignment = .center
        return label
    }()

    let arrivalStationLabel: UILabel = {
        let label = UILabel()
        label.text = "抵達"
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .lizOrenge
        label.textAlignment = .center
        return label
    }()

    lazy var departureStationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("臺北", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.applyRoundedBorder(radius: 30)
        button.addTarget(self, action: #selector(tapDepartureStationButton), for: .touchUpInside)
        return button
    }()

    lazy var exchangeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow.left.arrow.right"), for: .normal)
        button.addTarget(self, action: #selector(tapExchangeButton), for: .touchUpInside)
        return button
    }()

    lazy var arrivalStationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("南港", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.applyRoundedBorder(radius: 30)
        button.addTarget(self, action: #selector(tapArrivalStationButton), for: .touchUpInside)
        return button
    }()

    lazy var dateButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("2023/07/06 23:56", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.applyRoundedBorder(radius: 25)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapDateButton), for: .touchUpInside)
        return button
    }()

    lazy var currentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("現在", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.applyRoundedBorder(radius: 25)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapCurrentButton), for: .touchUpInside)
        return button
    }()

    lazy var byDepartureTimeAndByArrivalTimeSegment: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["出發時間", "抵達時間"])
        sc.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.label], for: .normal)
        sc.selectedSegmentTintColor = .lizOrenge
        sc.backgroundColor = UIColor(red: 239/255, green: 176/255, blue: 82/255, alpha: 0.4)
        sc.selectedSegmentIndex = 0
        sc.addTarget(self, action: #selector(handleByDepartureTimeAndByArrivalTimeSegment), for: .valueChanged)
        return sc
    }()

    let directAndTransferSegment: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["直達", "轉乘"])
        sc.setTitleTextAttributes([.font : UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.label], for: .normal)
        sc.selectedSegmentTintColor = .lizOrenge
        sc.backgroundColor = UIColor(red: 239/255, green: 176/255, blue: 82/255, alpha: 0.4)
        sc.selectedSegmentIndex = 0
        return sc
    }()

    lazy var inquireButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("查詢", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.applyRoundedBorder(radius: 30)
        button.titleLabel?.font = .systemFont(ofSize: 24)
        button.addTarget(self, action: #selector(tapInquireButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleByDepartureTimeAndByArrivalTimeSegment(sender: UISegmentedControl) {
        delegate?.didTapByDepartureTimeAndByArrivalTimeSegment(sender: sender)
    }
    
    @objc private func tapCurrentButton() {
        delegate?.didTapCurrentButton()
    }
    
    @objc private func tapDateButton() {
        delegate?.didTapDateButton()
    }
    
    @objc private func tapInquireButton() {
        delegate?.didTapInquireButton()
    }
    
    @objc private func tapDepartureStationButton() {
        delegate?.didTapDepartureStationButton()
    }
    
    @objc private func tapArrivalStationButton() {
        delegate?.didTapArrivalStationButton()
    }
    
    @objc private func tapExchangeButton() {
        delegate?.didTapExchangButton()
    }
    
    public func updateView(departure: String, arrival: String, dateAndTime: String) {
        departureStationButton.setTitle(departure, for: .normal)
        arrivalStationButton.setTitle(arrival, for: .normal)
        dateButton.setTitle(dateAndTime, for: .normal)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(departureStationLabel)
        addSubview(departureStationButton)
        addSubview(arrivalStationLabel)
        addSubview(arrivalStationButton)
        addSubview(exchangeButton)
        addSubview(dateButton)
        addSubview(currentButton)
        addSubview(byDepartureTimeAndByArrivalTimeSegment)
        addSubview(directAndTransferSegment)
        addSubview(inquireButton)
        setupLayout()
    }
    
    private func setupLayout() {
        
        departureStationLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            make.leading.trailing.equalTo(departureStationButton)
            make.height.equalTo(20)
        }

        departureStationButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.trailing.equalTo(exchangeButton.snp.leading)
            make.leading.equalToSuperview().offset(5)
            make.top.equalTo(departureStationLabel.snp.bottom).offset(10)
        }
        
        arrivalStationLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(5)
            make.leading.trailing.equalTo(arrivalStationButton)
            make.height.equalTo(20)
        }
        
        arrivalStationButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.trailing.equalToSuperview().offset(-5)
            make.leading.equalTo(exchangeButton.snp.trailing)
            make.top.equalTo(arrivalStationLabel.snp.bottom).offset(10)
        }
        
        exchangeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.top.bottom.equalTo(departureStationButton)
        }
        
        dateButton.snp.makeConstraints { make in
            make.top.equalTo(departureStationButton.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(5)
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalTo(50)
        }
        
        currentButton.snp.makeConstraints { make in
            make.top.height.equalTo(dateButton)
            make.trailing.equalToSuperview().offset(-5)
            make.leading.equalTo(dateButton.snp.trailing).offset(5)
        }
        
        byDepartureTimeAndByArrivalTimeSegment.snp.makeConstraints { make in
            make.top.equalTo(dateButton.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(departureStationButton)
            make.trailing.equalTo(arrivalStationButton)
        }
        
        directAndTransferSegment.snp.makeConstraints { make in
            make.top.equalTo(byDepartureTimeAndByArrivalTimeSegment.snp.bottom).offset(20)
            make.height.equalTo(50)
            make.leading.equalTo(departureStationButton)
            make.trailing.equalTo(arrivalStationButton)
        }
        
        inquireButton.snp.makeConstraints { make in
            make.top.equalTo(directAndTransferSegment.snp.bottom).offset(20)
            make.height.equalTo(60)
            make.leading.equalTo(departureStationButton)
            make.trailing.equalTo(arrivalStationButton)
        }
        
    }
    
}
