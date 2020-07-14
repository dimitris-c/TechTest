//
//  AppDelegate.swift
//  CuvvaTechTest
//
//  Created by Dimitrios Chatzieleftheriou on 13/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var appController: AppController?
    let services = ServicesContainer()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let appController = AppController(window: window, services: services)
        self.window = window
        self.appController = appController
        
        appController.start()
        return true
    }
    

}

