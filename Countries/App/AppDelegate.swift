//
//  AppDelegate.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

    import UIKit
    import CoreData

    @main
    class AppDelegate: UIResponder, UIApplicationDelegate {
        
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            return true
        }
        
        lazy var persistentContainer: NSPersistentContainer = {
            
            let container = NSPersistentContainer(name: "Countries")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
        
        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }
        


}

