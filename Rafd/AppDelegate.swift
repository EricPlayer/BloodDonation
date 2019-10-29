//
//  AppDelegate.swift
//  Rafd
//
//  Created by eric on 3/20/19.
//  Copyright © 2019 eric. All rights reserved.
//

import UIKit
import CoreData
import Alamofire

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var findcityresults = ["الكل"]
    var findbloodresults = ["الكل"]
    var donatecityresults = ["اختر"]
    var donatebloodresults = ["اختر"]


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        getCities()
        getBloods()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func getCities() {
        let url: String = "http://dip.com.sa/rafdapi/index.php/donation/citylist"
        Alamofire.request(url).validate().responseString { (response) in
            switch response.result {
                case .success:
                    let string_data = response.description
                    var cityString = string_data.replacingOccurrences(of: "]", with: "") + ","
                    while cityString.count > 0 {
                        if let startIdx = cityString.index(of: "{") {
                            let temp = String(cityString[cityString.index(after: startIdx)..<cityString.endIndex])
                            cityString = String(cityString[startIdx..<cityString.endIndex])
                            if let endIdx = temp.index(of: "}") {
                                let substr = String(temp[temp.startIndex..<endIdx])
                                let anArr = substr.components(separatedBy: ",")
                                let nameArr = anArr[1].components(separatedBy: ":")
                                cityString = cityString.replacingOccurrences(of: "{"+substr+"},", with: "")
                                let wI = NSMutableString( string: nameArr[1] )
                                CFStringTransform( wI, nil, "Any-Hex/Java" as NSString, true )
                                var cityName = wI as String
                                cityName = cityName.replacingOccurrences(of: "\"", with: "")
                                self.findcityresults.append(cityName)
                                self.donatecityresults.append(cityName)
                            }
                        }
                    }
                case .failure(let error):
                    print("failed to load citylist: \(error.localizedDescription)")
            }
        }
    }
    
    func getBloods() {
        let url: String = "http://dip.com.sa/rafdapi/index.php/donation/bloodlist"
        Alamofire.request(url).validate().responseString { (response) in
            switch response.result {
            case .success:
                let string_data = response.description
                var bloodString = string_data.replacingOccurrences(of: "]", with: "") + ","
                while bloodString.count > 0 {
                    if let startIdx = bloodString.index(of: "{") {
                        let temp = String(bloodString[bloodString.index(after: startIdx)..<bloodString.endIndex])
                        bloodString = String(bloodString[startIdx..<bloodString.endIndex])
                        if let endIdx = temp.index(of: "}") {
                            let substr = String(temp[temp.startIndex..<endIdx])
                            let anArr = substr.components(separatedBy: ",")
                            let nameArr = anArr[1].components(separatedBy: ":")
                            bloodString = bloodString.replacingOccurrences(of: "{"+substr+"},", with: "")
                            let bloodName = nameArr[1].replacingOccurrences(of: "\"", with: "")
                            self.findbloodresults.append(bloodName)
                            self.donatebloodresults.append(bloodName)
                        }
                    }
                }
                case .failure(let error):
                    print("failed to load bloodlist: \(error.localizedDescription)")
            }
        }
    }
}

