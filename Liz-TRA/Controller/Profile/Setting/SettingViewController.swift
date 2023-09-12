//
//  SettingViewController.swift
//  Liz-TRA
//
//  Created by Machir on 2023/8/29.
//

import UIKit
import AuthenticationServices

//這個controller已整理完2023.09.08
class SettingViewController: UIViewController {
    
    private let tableview = UITableView()
    private var titleData = ["登出", "刪除帳號"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView() {
        tableview.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        view.addSubview(tableview)
        
        tableview.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        tableview.dataSource = self
        tableview.delegate = self
    }

}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else { return UITableViewCell() }
        let title = titleData[indexPath.row]
        cell.updateCell(title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard UserManager.shared.currentUser != nil else { return }
        switch indexPath.row {
            
        case 0:
            let alert = UIAlertController(title: "登出", message: "確定要登出嗎？", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "取消", style: .default))
            alert.addAction(UIAlertAction(title: "登出", style: .destructive, handler: { _ in
                UserManager.shared.signOut()
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
            
        case 1:
            let alert = UIAlertController(title: "要刪除帳號嗎？", message: "刪除帳號後資料將永久不可復原，確定要刪除帳號嗎？", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "取消", style: .default))
            alert.addAction(UIAlertAction(title: "刪除帳號", style: .destructive, handler: { _ in
                UserManager.shared.deleteUser()
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true)
            
        default:
            break
        }
        
    }

}
