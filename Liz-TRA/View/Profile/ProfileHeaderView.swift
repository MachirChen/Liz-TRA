//
//  ProfileHeaderView.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/24.
//

import UIKit
import SnapKit

protocol ProfileHeaderViewDelegate: AnyObject {
    func didTapLoginButton()
}

class ProfileHeaderView: UIView {
    
    weak var delegate: ProfileHeaderViewDelegate?
    
    private let photoView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Liz-Logo")
        view.cornerRadii(radii: 40)
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "尚未登入"
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(handleLoginButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func handleLoginButton() {
        delegate?.didTapLoginButton()
    }
    
    public func updateProfileHV(photo: UIImage, name: String) {
        photoView.image = photo
        nameLabel.text = name
    }
    
    public func updateProfileHV(name: String) {
        nameLabel.text = name
    }
    
    private func setupView() {
        backgroundColor = .systemBackground
        addSubview(photoView)
        addSubview(nameLabel)
        addSubview(loginButton)
        setupLayout()
    }
    
    private func setupLayout() {
        photoView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(photoView.snp.trailing).offset(10)
            make.top.equalTo(photoView)
            make.width.equalTo(100)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.top.bottom.equalTo(photoView)
            make.trailing.equalToSuperview()
        }
    }
    
}
