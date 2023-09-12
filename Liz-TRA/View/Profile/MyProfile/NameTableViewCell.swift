//
//  NameTableViewCell.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/27.
//

import UIKit

class NameTableViewCell: UITableViewCell {
    
    private let nameTitle: UILabel = {
        let label = UILabel()
        label.text = "名字"
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = "你的名字"
        label.textColor = .label
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func updateNameLabel(text: String) {
        subTitle.text = text
    }
    
    private func setupView() {
        contentView.addSubview(nameTitle)
        contentView.addSubview(subTitle)
        setupLayout()
    }
    
    private func setupLayout() {
        nameTitle.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        subTitle.snp.makeConstraints { make in
            make.leading.trailing.height.equalTo(nameTitle)
            make.top.equalTo(nameTitle.snp.bottom).offset(5)
        }
    }
    
}


