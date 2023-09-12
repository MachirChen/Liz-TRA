//
//  TrainScheduleInquiryResultTableViewCell.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/8.
//

import UIKit
import SnapKit

class TrainScheduleInquiryResultTableViewCell: UITableViewCell {
    
    private let trainTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "自強3000"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let trainCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "161"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()

    private let departureTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "08:08"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrow.right")
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .center
        return imageView
    }()
    
    private let arrivalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "09:38"
        label.font = .systemFont(ofSize: 20)
        label.textColor = .label
        label.textAlignment = .center
        return label
    }()
    
    private let travelTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "1小時30分"
        label.textColor = .lizOrenge
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        return label
    }()
    
    public let onTimeAndDelayLabel: UILabel = {
        let label = UILabel()
        label.text = "準點"
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let ticketPriceLabel: UILabel = {
        let label = UILabel()
        label.text = "$230"
        label.textColor = .lizOrenge
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCell(_ trainSchedule: TrainTimetable, travelTime: String, ticketPrice: String) {
        trainTypeLabel.text = trainSchedule.trainInfo.trainTypeName.zhTw
        trainCodeLabel.text = trainSchedule.trainInfo.trainNo
        departureTimeLabel.text = trainSchedule.stopTimes[0].departureTime
        arrivalTimeLabel.text = trainSchedule.stopTimes.reversed()[0].arrivalTime
        travelTimeLabel.text = travelTime
        ticketPriceLabel.text = "$\(ticketPrice)"
//        onTimeAndDelayLabel.text = "\(trainSchedule.trainInfo.delayTime)"
    }
    
    private func setupView() {
        contentView.addSubview(trainTypeLabel)
        contentView.addSubview(trainCodeLabel)
        contentView.addSubview(departureTimeLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(arrivalTimeLabel)
        contentView.addSubview(travelTimeLabel)
        contentView.addSubview(onTimeAndDelayLabel)
        contentView.addSubview(ticketPriceLabel)
        setLayout()
    }
    
    private func setLayout() {
        
//        let trainTypeAndCodeStackView = UIStackView(arrangedSubviews: [trainTypeLabel, trainCodeLabel])
//        trainTypeAndCodeStackView.axis = .vertical
//        trainTypeAndCodeStackView.alignment = .fill
//        trainTypeAndCodeStackView.distribution = .fill
//        addSubview(trainTypeAndCodeStackView)
//        trainTypeAndCodeStackView.snp.makeConstraints { make in
//            make.centerY.equalTo(self.snp.centerY)
//            make.width.equalTo(100)
//        }
//
//        let departureAndArrivalTimeStackView = UIStackView(arrangedSubviews: [departureTimeLabel, arrowImageView, arrivalTimeLabel])
//        departureAndArrivalTimeStackView.axis = .horizontal
//        departureAndArrivalTimeStackView.alignment = .center
//        departureAndArrivalTimeStackView.distribution = .fill
//        addSubview(departureAndArrivalTimeStackView)
//        departureAndArrivalTimeStackView.snp.makeConstraints { make in
//            make.centerY.equalTo(self.snp.centerY)
//            make.width.equalTo(100)
//        }
//

        
        
        trainTypeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.bottom.equalTo(contentView.snp.centerY).offset(-2)
            make.width.equalTo(100)
        }

        trainCodeLabel.snp.makeConstraints { make in
            make.leading.trailing.equalTo(trainTypeLabel)
            make.top.equalTo(contentView.snp.centerY).offset(2)
        }
        
        ticketPriceLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview()
            make.width.equalTo(60)
        }
        
        onTimeAndDelayLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(ticketPriceLabel.snp.leading)
            make.width.equalTo(40)
        }
        
        departureTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(trainTypeLabel.snp.trailing)
            make.bottom.equalTo(contentView.snp.centerY).offset(-2)
            make.width.equalTo(60)
        }

        arrowImageView.snp.makeConstraints { make in
            make.leading.equalTo(departureTimeLabel.snp.trailing)
            make.trailing.equalTo(arrivalTimeLabel.snp.leading)
            make.top.bottom.equalTo(departureTimeLabel)
        }

        arrivalTimeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(onTimeAndDelayLabel.snp.leading).offset(-10)
            make.width.equalTo(departureTimeLabel)
            make.top.bottom.equalTo(departureTimeLabel)
        }

        travelTimeLabel.snp.makeConstraints { make in
            make.centerX.equalTo(arrowImageView)
            make.top.equalTo(contentView.snp.centerY).offset(2)
        }
        

        
    }
    
}
