//
//  AppDelegate.swift
//  PostingProject
//
//  Created by LUCAS on 6/20/19.
//  Copyright © 2019 Atomiton. All rights reserved.
//

import UIKit
import CoreData
import GoogleSignIn
import FacebookCore
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupStyle()
        checkAndRedirect()
        
        //Google Delegate
        GIDSignIn.sharedInstance()?.clientID = C.GoogleCerts.clientID
        
        //Facebook Delegate
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        let facebookDidHandle :Bool = ApplicationDelegate.shared.application(app, open: url, options: options)
        let googleDidHandle: Bool = GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplication.OpenURLOptionsKey.sourceApplication] as? String, annotation: [:])
        
        return facebookDidHandle || googleDidHandle
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "PostingProject")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func setupStyle() {
        window?.tintColor = C.Color.BG.orange
        
        //Navbar
        let appearance = UINavigationBar.appearance()
        appearance.tintColor =  C.Color.BG.snow
        appearance.barTintColor = C.Color.BG.orange
        appearance.isTranslucent = false
        appearance.barStyle = .black
        appearance.titleTextAttributes = [
//            NSAttributedString.Key.font: UIFont(name: "Roboto-Regular", size: 17)!,
            NSAttributedString.Key.foregroundColor: C.Color.BG.snow
        ]
    }
    
    func setupDropdown() {
        
    }
    
    func checkAndRedirect() {
        guard UserProfile.parseData().result else { return }
        
        let storyboard = UIStoryboard(name: C.StoryboardID.storyboardName, bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: C.StoryboardID.tabbar)
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
}

