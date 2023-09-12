//
//  JGProgressHUD+.swift
//  Liz-TRA
//
//  Created by Machir on 2023/9/11.
//

import JGProgressHUD

class MJGProgressHUD {
    
    static let shared = MJGProgressHUD()
    
    var view: UIView {
        guard let view = UIApplication.shared.windows.last?.rootViewController?.view else { return UIView() }
        return view
    }
    
    private init() {}
    
    let hud = JGProgressHUD()
    
    static func show(text: String? = nil) {
        
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                show(text: text)
            }
            print("!Thread.isMainThread")
            return
        }
        print("Thread.isMainThread")
        //可以加入view did load test
        shared.hud.textLabel.text = text
        shared.hud.indicatorView = JGProgressHUDIndeterminateIndicatorView()
        shared.hud.show(in: shared.view)
    }

    static func dismiss() {
        if !Thread.isMainThread {
            DispatchQueue.main.async {
                dismiss()
            }
            print("!Thread.isMainThread")
            return
        }
        shared.hud.dismiss()
        print("Thread.isMainThread")
    }
}


