//
//  UIImageView+.swift
//  Liz-TRA
//
//  Created by Machir on 2023/9/6.
//

import UIKit

extension UIImageView {
    func fetchImage(url: String) {
        let url = URL(string: url)!
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)!
                }
            }
        }.resume()
    }
}
