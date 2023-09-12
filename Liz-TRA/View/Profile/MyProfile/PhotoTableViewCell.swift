//
//  PhotoTableViewCell.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/27.
//

import UIKit
import SnapKit

protocol PhotoTableViewCellDelegate: AnyObject {
    func didTapPhotoButton()
}

class PhotoTableViewCell: UITableViewCell {
    
    weak var delegate: PhotoTableViewCellDelegate?
    
    private lazy var photoView: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Liz-Logo"), for: .normal)
        button.addTarget(self, action: #selector(tapPhotoButton), for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        button.cornerRadii(radii: 40)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
    @objc private func tapPhotoButton() {
        delegate?.didTapPhotoButton()
    }
    
    public func updatePhoto(image: UIImage) {
        photoView.setImage(image, for: .normal)
    }
    
    private func setupView() {
        contentView.addSubview(photoView)
        setupLayout()
    }
    
    private func setupLayout() {
        photoView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(80)
        }
    }
    
}
