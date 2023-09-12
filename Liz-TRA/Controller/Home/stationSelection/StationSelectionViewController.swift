//
//  StationSelectionViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/10.
//

import UIKit
import SnapKit

protocol StationSelectionViewControllerDelegate: AnyObject {
    func didDismissStationSelectionViewController()
}

class StationSelectionViewController: UIViewController {
    
    //MARK: - Property
    weak var delegate: StationSelectionViewControllerDelegate?
    public var isDepartureStation: Bool!
    private let cities = CityData.cities
    private let stationSelectionView = StationSelectionView()
    private var cityTableView = UITableView()
    private var stationNameTableView = UITableView()
    private var selectedCityIndex = Int()
    private var selectedStationIndex = Int()
    private var trainScheduleData = [TrainSchedule]()
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStationSelectionView()
        view.backgroundColor = .systemBackground
        setupCityTableView()
        setupStationNameTableView()
        setupNavigation()
        fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        delegate?.didDismissStationSelectionViewController()
    }
    
    
    //MARK: - Method

    private func fetchData() {
        trainScheduleData = CoreDataManager.shared.fetchTrainScheduleData()
        getSelectedCityIndex()
        getSelectedStationIndex()
        changeStationButtonAppearance()
        DispatchQueue.main.async {
            self.stationSelectionView.updateView(departure: self.trainScheduleData[0].departureStation!, arrival: self.trainScheduleData[0].arrivalStation!)
            self.cityTableView.scrollToRow(at: IndexPath(row: self.selectedCityIndex, section: 0), at: .middle, animated: true)
            self.stationNameTableView.scrollToRow(at: IndexPath(row: self.selectedStationIndex, section: 0), at: .middle, animated: true)
        }
    }
    
    private func getSelectedCityIndex() {
        trainScheduleData = CoreDataManager.shared.fetchTrainScheduleData()
        if isDepartureStation {
            for (index, city) in cities.enumerated() {
                if city.stations.contains(where: { $0.name == trainScheduleData[0].departureStation }) {
                    self.selectedCityIndex = index
                }
            }
        } else {
            for (index, city) in cities.enumerated() {
                if city.stations.contains(where: { $0.name == trainScheduleData[0].arrivalStation }) {
                    self.selectedCityIndex = index
                }
            }
        }
    }
    
    private func getSelectedStationIndex() {
        trainScheduleData = CoreDataManager.shared.fetchTrainScheduleData()
        if isDepartureStation {
            for (index, station) in cities[selectedCityIndex].stations.enumerated() {
                if station.name == trainScheduleData[0].departureStation {
                    self.selectedStationIndex = index
                }
            }
        } else {
            for (index, station) in cities[selectedCityIndex].stations.enumerated() {
                if station.name == trainScheduleData[0].arrivalStation {
                    self.selectedStationIndex = index
                }
            }
        }
    }
    
    private func changeStationButtonAppearance() {
        if isDepartureStation {
            stationSelectionView.departureStationButton.applyRoundedBorder(radius: 30)
            stationSelectionView.arrivalStationButton.removeRoundedBorder()
        } else {
            stationSelectionView.departureStationButton.removeRoundedBorder()
            stationSelectionView.arrivalStationButton.applyRoundedBorder(radius: 30)
        }
    }
    //儲存StationID
    private func changeTrainScheduleData() {
        if isDepartureStation {
            trainScheduleData[0].departureId = cities[self.selectedCityIndex].stations[self.selectedStationIndex].id
            CoreDataManager.shared.changeTrainSchedule(data: trainScheduleData[0])
        } else {
            trainScheduleData[0].arrivalId = cities[self.selectedCityIndex].stations[self.selectedStationIndex].id
            CoreDataManager.shared.changeTrainSchedule(data: trainScheduleData[0])
        }
    }
    
    private func setupNavigation() {
        navigationItem.title = "選擇車站"
        let finishButton = UIBarButtonItem(title: "完成", style: .plain, target: self, action: #selector(handleFinishButton))
        finishButton.tintColor = .lizOrenge
        navigationItem.rightBarButtonItem = finishButton
    }
    
    @objc private func handleFinishButton() {
        dismiss(animated: true)
    }
    
    private func setupStationSelectionView() {
        view.addSubview(stationSelectionView)
        stationSelectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(110)
        }
        stationSelectionView.delegate = self
    }
    
    private func setupCityTableView() {
        view.addSubview(cityTableView)
        cityTableView.snp.makeConstraints { make in
            make.top.equalTo(stationSelectionView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.leading.equalToSuperview()
            make.width.equalTo(view.frame.width / 2 - 5)
        }
        cityTableView.dataSource = self
        cityTableView.delegate = self
        cityTableView.register(CityTableViewCell.self, forCellReuseIdentifier: CityTableViewCell.identifier)
    }
    
    private func setupStationNameTableView() {
        view.addSubview(stationNameTableView)
        stationNameTableView.snp.makeConstraints { make in
            make.top.equalTo(stationSelectionView.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
            make.trailing.equalToSuperview()
            make.width.equalTo(view.frame.width / 2 - 5)
        }
        stationNameTableView.dataSource = self
        stationNameTableView.delegate = self
        stationNameTableView.register(StationNameTableViewCell.self, forCellReuseIdentifier: StationNameTableViewCell.identifier)
    }
    
}

//MARK: - TableViewDataSource

extension StationSelectionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.cityTableView {
            return cities.count
        } else if tableView == self.stationNameTableView {
            return cities[self.selectedCityIndex].stations.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.cityTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CityTableViewCell.identifier, for: indexPath) as? CityTableViewCell else { return UITableViewCell() }
            cell.updateCell(city: cities[indexPath.row].name)
            if indexPath.row == selectedCityIndex {
                cell.backgroundColor = .lizOrenge
            } else {
                cell.backgroundColor = .clear
            }
            return cell
        } else if tableView == self.stationNameTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: StationNameTableViewCell.identifier, for: indexPath) as? StationNameTableViewCell else { return UITableViewCell() }
            cell.updateCell(station: cities[selectedCityIndex].stations[indexPath.row].name)
            if indexPath.row == selectedStationIndex {
                cell.backgroundColor = .lizOrenge
            } else {
                cell.backgroundColor = .clear
            }
            return cell
        }
        return UITableViewCell()
    }
}

//MARK: - TableViewDelegate

extension StationSelectionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.cityTableView {
            if isDepartureStation {
                switch cities[indexPath.row].name {
                case "新北":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: "板橋", arrivalStation: trainScheduleData[0].arrivalStation!)
                case "南投":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: "集集", arrivalStation: trainScheduleData[0].arrivalStation!)
                case "雲林":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: "斗六", arrivalStation: trainScheduleData[0].arrivalStation!)
                case "成追線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: "追分", arrivalStation: trainScheduleData[0].arrivalStation!)
                case "平溪線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: "三貂嶺", arrivalStation: trainScheduleData[0].arrivalStation!)
                case "深澳線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: "瑞芳", arrivalStation: trainScheduleData[0].arrivalStation!)
                case "六家線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: "竹中", arrivalStation: trainScheduleData[0].arrivalStation!)
                case "內灣線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: "北新竹", arrivalStation: trainScheduleData[0].arrivalStation!)
                case "集集線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: "二水", arrivalStation: trainScheduleData[0].arrivalStation!)
                case "沙崙線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: "中洲", arrivalStation: trainScheduleData[0].arrivalStation!)
                default:
                    CoreDataManager.shared.editTrainScheduleData(departureStation: cities[indexPath.row].name, arrivalStation: trainScheduleData[0].arrivalStation!)
                }
            } else {
                switch cities[indexPath.row].name {
                case "新北":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: "板橋")
                case "南投":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: "集集")
                case "雲林":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: "斗六")
                case "成追線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: "追分")
                case "平溪線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: "三貂嶺")
                case "深澳線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: "瑞芳")
                case "六家線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: "竹中")
                case "內灣線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: "北新竹")
                case "集集線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: "二水")
                case "沙崙線":
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: "中洲")
                default:
                    CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: cities[indexPath.row].name)
                }
            }
            getSelectedCityIndex()
            getSelectedStationIndex()
            changeTrainScheduleData()
            trainScheduleData = CoreDataManager.shared.fetchTrainScheduleData()
            stationSelectionView.updateView(departure: trainScheduleData[0].departureStation!, arrival: trainScheduleData[0].arrivalStation!)
            cityTableView.reloadData()
            stationNameTableView.reloadData()
            DispatchQueue.main.async {
                self.stationNameTableView.scrollToRow(at: IndexPath(row: self.selectedStationIndex, section: 0), at: .middle, animated: true)
            }
        } else if tableView == self.stationNameTableView {
            if isDepartureStation {
                CoreDataManager.shared.editTrainScheduleData(departureStation: cities[selectedCityIndex].stations[indexPath.row].name, arrivalStation: trainScheduleData[0].arrivalStation!)
            } else {
                CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].departureStation!, arrivalStation: cities[selectedCityIndex].stations[indexPath.row].name)
            }
            getSelectedStationIndex()
            changeTrainScheduleData()
            trainScheduleData = CoreDataManager.shared.fetchTrainScheduleData()
            stationSelectionView.updateView(departure: trainScheduleData[0].departureStation!, arrival: trainScheduleData[0].arrivalStation!)
            stationNameTableView.reloadData()
        }
    }
}

//MARK: - StationSelectionViewDelegate

extension StationSelectionViewController: StationSelectionViewDelegate {
    func didTapDepartureStationButton() {
        isDepartureStation = true
        getSelectedCityIndex()
        getSelectedStationIndex()
        changeStationButtonAppearance()
        cityTableView.reloadData()
        stationNameTableView.reloadData()
        DispatchQueue.main.async {
            self.cityTableView.scrollToRow(at: IndexPath(row: self.selectedCityIndex, section: 0), at: .middle, animated: true)
            self.stationNameTableView.scrollToRow(at: IndexPath(row: self.selectedStationIndex, section: 0), at: .middle, animated: true)
        }
    }
    
    func didTapArrivalStationButton() {
        isDepartureStation = false
        getSelectedCityIndex()
        getSelectedStationIndex()
        changeStationButtonAppearance()
        cityTableView.reloadData()
        stationNameTableView.reloadData()
        DispatchQueue.main.async {
            self.cityTableView.scrollToRow(at: IndexPath(row: self.selectedCityIndex, section: 0), at: .middle, animated: true)
            self.stationNameTableView.scrollToRow(at: IndexPath(row: self.selectedStationIndex, section: 0), at: .middle, animated: true)
        }
    }
    
    func didTapExchangeButton() {
        CoreDataManager.shared.editTrainScheduleData(departureStation: trainScheduleData[0].arrivalStation!, departureId: trainScheduleData[0].arrivalId!, arrivalStation: trainScheduleData[0].departureStation!, arrivalId: trainScheduleData[0].departureId!)
        fetchData()
        cityTableView.reloadData()
        stationNameTableView.reloadData()
    }
}
