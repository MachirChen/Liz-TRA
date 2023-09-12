//
//  SettingTableViewCell.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/29.
//

import UIKit
import SnapKit

class SettingTableViewCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "登出"
        label.textColor = .systemRed
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateCell(title: String) {
        titleLabel.text = title
    }
    
    private func setupView() {
        contentView.addSubview(titleLabel)
        setupLayout()
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
