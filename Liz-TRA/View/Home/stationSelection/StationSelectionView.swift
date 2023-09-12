//
//  stationSelectionView.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/9.
//

import UIKit

protocol StationSelectionViewDelegate: AnyObject {
    func didTapExchangeButton()
    func didTapDepartureStationButton()
    func didTapArrivalStationButton()
}

class StationSelectionView: UIView {
    
    weak var delegate: StationSelectionViewDelegate?
    
    private let departureStationLabel: UILabel = {
        let label = UILabel()
        label.text = "出發站"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lizOrenge
        label.textAlignment = .center
        return label
    }()

    private let arrivalStationLabel: UILabel = {
        let label = UILabel()
        label.text = "抵達站"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lizOrenge
        label.textAlignment = .center
        return label
    }()

    lazy var departureStationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("臺北", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.setTitleColor(.label, for: .normal)
        button.applyRoundedBorder(radius: 30)
        button.addTarget(self, action: #selector(tapDepartureStationButton), for: .touchUpInside)
        return button
    }()

    lazy var exchangeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "arrow.left.arrow.right"), for: .normal)
        button.addTarget(self, action: #selector(tapExchangeButtin), for: .touchUpInside)
        return button
    }()

    lazy var arrivalStationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("南港", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.setTitleColor(.label, for: .normal)
        button.applyRoundedBorder(radius: 30)
        button.addTarget(self, action: #selector(tapArrivalStationButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func tapExchangeButtin() {
        delegate?.didTapExchangeButton()
    }
    
    @objc private func tapDepartureStationButton() {
        delegate?.didTapDepartureStationButton()
    }
    
    @objc private func tapArrivalStationButton() {
        delegate?.didTapArrivalStationButton()
    }
    
    public func updateView(departure: String, arrival: String) {
        departureStationButton.setTitle(departure, for: .normal)
        arrivalStationButton.setTitle(arrival, for: .normal)
    }
    
    private func setupView() {
        addSubview(departureStationLabel)
        addSubview(departureStationButton)
        addSubview(arrivalStationLabel)
        addSubview(arrivalStationButton)
        addSubview(exchangeButton)
        setupLayout()
    }
    
    private func setupLayout() {
        
        departureStationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.trailing.equalTo(departureStationButton)
            make.height.equalTo(20)
        }

        departureStationButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.trailing.equalTo(exchangeButton.snp.leading)
            make.leading.equalToSuperview().offset(5)
            make.top.equalTo(departureStationLabel.snp.bottom).offset(10)
        }
        
        arrivalStationLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.leading.trailing.equalTo(arrivalStationButton)
            make.height.equalTo(20)
        }
        
        arrivalStationButton.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.trailing.equalToSuperview().offset(-5)
            make.leading.equalTo(exchangeButton.snp.trailing)
            make.top.equalTo(arrivalStationLabel.snp.bottom).offset(10)
        }
        
        exchangeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(60)
            make.top.bottom.equalTo(departureStationButton)
        }
        
    }
    
}
