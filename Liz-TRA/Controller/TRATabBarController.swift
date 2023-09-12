//
//  TRATabBarController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/7/6.
//

import UIKit

private enum Tab {
    case home

    case profile

    func controller() -> UIViewController {
        var controller: UIViewController

        switch self {
        case .home:
            controller = UINavigationController(rootViewController: HomeViewController())
            
        case .profile:
            controller = UINavigationController(rootViewController: ProfileViewController())
        }

        controller.tabBarItem = tabBarItem()
        controller.tabBarItem.imageInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        return controller
    }

    func tabBarItem() -> UITabBarItem {
        switch self {
        case .home:
            return UITabBarItem(title: nil, image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))

        case .profile:
            return UITabBarItem(title: nil, image: UIImage(systemName: "person.circle"), selectedImage: UIImage(systemName: "person.circle.fill"))
        }
    }
}

class TRATabBarController: UITabBarController {
    
    private let tabs: [Tab] = [.home, .profile]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = tabs.map({ $0.controller() })
        tabBar.backgroundColor = .systemBackground
        
        TokenManager.shared.getToken()
        TrainScheduleManager.shared.getTrainSchedule()
        if TrainScheduleManager.shared.trainSchedule.isEmpty {
            CoreDataManager.shared.saveTrainScheduleData()
        }
    }

    
}
