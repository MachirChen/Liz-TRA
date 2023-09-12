//
//  TrainNumberDetailTableViewCell.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/22.
//

import UIKit
import SnapKit

class TrainNumberDetailTableViewCell: UITableViewCell {
    
    private let stationName: UILabel = {
        let label = UILabel()
        label.text = "臺北"
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let arrivalTime: UILabel = {
        let label = UILabel()
        label.text = "12:00"
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    private let departureTime: UILabel = {
        let label = UILabel()
        label.text = "12:02"
        label.textAlignment = .left
        label.textColor = .label
        return label
    }()
    
    public let nextStation: UILabel = {
        let label = UILabel()
        label.text = "準點"
        label.textAlignment = .left
        label.textColor = .lizOrenge
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCell(_ data: StopTime, _ Station: String) {
        stationName.text = data.stationName.zhTw
        arrivalTime.text = data.arrivalTime
        departureTime.text = data.departureTime
        nextStation.text = Station
    }
    
    private func setupView() {
        contentView.addSubview(stationName)
        contentView.addSubview(arrivalTime)
        contentView.addSubview(departureTime)
        contentView.addSubview(nextStation)
        setupLayout()
    }
    
    private func setupLayout() {
        stationName.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.width.equalTo(60)
        }
        
        arrivalTime.snp.makeConstraints { make in
            make.centerY.equalTo(stationName)
            make.leading.equalTo(stationName.snp.trailing).offset(30)
            make.width.equalTo(50)
        }
        
        departureTime.snp.makeConstraints { make in
            make.centerY.equalTo(stationName)
            make.leading.equalTo(arrivalTime.snp.trailing).offset(20)
            make.width.equalTo(50)
        }
        
        nextStation.snp.makeConstraints { make in
            make.centerY.equalTo(stationName)
            make.leading.equalTo(departureTime.snp.trailing).offset(40)
            make.width.equalTo(80)
        }
    }
    
}
