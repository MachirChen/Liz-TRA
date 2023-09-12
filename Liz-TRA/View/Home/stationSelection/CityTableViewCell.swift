//
//  CityTableViewCell.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/10.
//

import UIKit
import SnapKit

class CityTableViewCell: UITableViewCell {
    
    private let cityLabel: UILabel = {
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
    
    public func updateCell(city: String) {
        cityLabel.text = city
    }
    
    private func setupView() {
        contentView.addSubview(cityLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        cityLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(5)
            make.bottom.trailing.equalToSuperview().offset(-5)
        }
    }
}
