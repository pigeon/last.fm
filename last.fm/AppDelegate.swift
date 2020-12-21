//
//  AppDelegate.swift
//  last.fm
//
//  Created by Dmytro Golub on 01/04/2018.
//   Dmytro Golub. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let api = LastFM_API("3812d751380a11228e55d28e67c4a01f", secret: "")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        if let navController = window?.rootViewController ,
           navController.children.count > 0 {
            if let searchController = navController.children[0] as? SearchViewController {
                if let moduleIntput = searchController.output as? SearchModuleInput {
                    moduleIntput.setSearchApiHandler(api)
                    moduleIntput.setSearchDetailsApiHandler(api)
                }
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {}

    func applicationWillTerminate(_ application: UIApplication) {}
}

