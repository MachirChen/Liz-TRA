//
//  DateAndTimeView.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/13.
//

import UIKit
import SnapKit

protocol DateAndTimeViewDelegate: AnyObject {
    func didTapConfirmButton()
    func didTapCancelButton()
    func didTapDateAndTimePicker(sender: UIDatePicker)
}

class DateAndTimeView: UIView {
    
    weak var delegate: DateAndTimeViewDelegate?
    
//    let blackView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .black
//        view.alpha = 0
//        return view
//    }()
//
//    let pickerBackgroundView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        return view
//    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("取消", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("確定", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.setTitleColor(.lizOrenge, for: .normal)
        button.addTarget(self, action: #selector(tapConfirmButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var dateAndTimePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .inline
        picker.datePickerMode = .dateAndTime
        picker.minuteInterval = 1
        picker.minimumDate = Date(timeIntervalSinceNow: -60*60*24)
        picker.maximumDate = Date(timeIntervalSinceNow: 60*60*24*60)
        picker.addTarget(self, action: #selector(tapDateAndTimePicker), for: .valueChanged)
        return picker
    }()
    
    @objc private func tapCancelButton() {
        delegate?.didTapCancelButton()
    }
    
    @objc private func tapConfirmButton() {
        delegate?.didTapConfirmButton()
    }
    
    @objc private func tapDateAndTimePicker(datePicker: UIDatePicker) {
        delegate?.didTapDateAndTimePicker(sender: datePicker)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
//        addSubview(pickerBackgroundView)
//        addSubview(blackView)
        
//        pickerBackgroundView.addSubview(cancelButton)
//        pickerBackgroundView.addSubview(confirmButton)
//        pickerBackgroundView.addSubview(dateAndTimePicker)
        addSubview(cancelButton)
        addSubview(confirmButton)
        addSubview(dateAndTimePicker)
        setupLayout()
    }
    
    private func setupLayout() {
        
//        pickerBackgroundView.snp.makeConstraints { make in
//            make.bottom.leading.trailing.equalToSuperview()
//            make.height.equalTo(500)
//        }
//        
//        blackView.snp.makeConstraints({ make in
//            make.top.leading.trailing.equalToSuperview()
//            make.bottom.equalTo(pickerBackgroundView.snp.top)
//        })
        
        cancelButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }

        confirmButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.top.equalToSuperview().offset(20)
            make.width.equalTo(70)
            make.height.equalTo(20)
        }
        
        dateAndTimePicker.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide)
        }

    }
    
}

