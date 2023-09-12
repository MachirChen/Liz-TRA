//
//  StationNameTableViewCell.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/10.
//

import UIKit

class StationNameTableViewCell: UITableViewCell {
    
    let stationLabel: UILabel = {
        let label = UILabel()
        label.text = "臺北"
        label.textColor = .label
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCell(station: String) {
        stationLabel.text = station
    }
    
    private func setupView() {
        contentView.addSubview(stationLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        stationLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
        }
    }
    
}
