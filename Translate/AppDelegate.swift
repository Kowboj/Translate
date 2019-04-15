//
//  AppDelegate.swift
//  Translate
//
//  Created by Kamil Chołyk on 15/04/2019.
//  Copyright © 2019 kowboj. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = TranslateViewController()
        window?.makeKeyAndVisible()
        
        return true
    }
}


