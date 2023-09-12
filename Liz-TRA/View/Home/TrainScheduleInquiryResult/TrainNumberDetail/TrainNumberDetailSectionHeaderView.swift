//
//  TrainNumberDetailSectionHeaderView.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/22.
//

import UIKit

class TrainNumberDetailSectionHeaderView: UIView {
    
    private let stationName: UILabel = {
        let label = UILabel()
        label.text = "站名"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lizOrenge
        return label
    }()
    
    private let arrivalTime: UILabel = {
        let label = UILabel()
        label.text = "到站"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lizOrenge
        return label
    }()
    
    private let departureTime: UILabel = {
        let label = UILabel()
        label.text = "離站"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lizOrenge
        return label
    }()
    
    private let nextStation: UILabel = {
        let label = UILabel()
        label.text = "即將進站"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15)
        label.textColor = .lizOrenge
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.backgroundColor = .systemBackground
        addSubview(stationName)
        addSubview(arrivalTime)
        addSubview(departureTime)
        addSubview(nextStation)
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
