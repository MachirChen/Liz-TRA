//
//  editNameView.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/27.
//

import UIKit
import SnapKit

protocol EditNameViewDelegate: AnyObject {
    func didTapSaveButton()
}

class EditNameView: UIView {
    
    weak var delegate: EditNameViewDelegate?
    
    private let nameTitle: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "名字"
        return label
    }()
    
    public let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = " 你的名字"
        textField.backgroundColor = .tertiarySystemFill
        textField.cornerRadii(radii: 5)
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.setTitle("儲存", for: .normal)
        button.setTitleColor(.tertiaryLabel, for: .normal)
        button.isEnabled = false
        button.cornerRadii(radii: 5)
        button.backgroundColor = .tertiarySystemFill
        button.addTarget(self, action: #selector(tapSaveButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapSaveButton() {
        delegate?.didTapSaveButton()
    }
    
    public func updateNameTextField(text: String) {
        nameTextField.text = text
    }
    
    public func updateSaveButton(enabled: Bool, backgroundColor: UIColor, titleColor: UIColor) {
        saveButton.isEnabled = enabled
        saveButton.backgroundColor = backgroundColor
        saveButton.setTitleColor(titleColor, for: .normal)
    }
    
    private func setupView() {
        self.backgroundColor = .systemBackground
        addSubview(nameTitle)
        addSubview(nameTextField)
        addSubview(saveButton)
        setupLayout()
    }
    
    private func setupLayout() {
        nameTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameTitle.snp.bottom).offset(5)
            make.leading.trailing.equalTo(nameTitle)
            make.height.equalTo(40)
        }
        
        saveButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(nameTitle)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.height.equalTo(50)
        }
    }
}
