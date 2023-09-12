//
//  bodyCollectionViewCell.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/26.
//

import UIKit
import SnapKit

protocol BodyCollectionViewCellDelegate: AnyObject {
    func didTapButton()
}

class BodyCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: BodyCollectionViewCellDelegate?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("  設定", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.setImage(UIImage(systemName: "gear"), for: .normal)
        button.addTarget(self, action: #selector(tapButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapButton() {
        delegate?.didTapButton()
    }
    
    private func setupView() {
        contentView.backgroundColor = .secondarySystemBackground
        self.cornerRadii(radii: 10)
        contentView.addSubview(button)
        setupLayout()
    }
    
    private func setupLayout() {
        button.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
    }
}
