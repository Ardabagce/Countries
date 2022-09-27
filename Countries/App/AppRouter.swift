//
//  AppRouter.swift
//  Countries
//
//  Created by Arda Bağçe on 27.09.2022.
//

import UIKit

final class AppRouter {
    
    func start(window: UIWindow) {
        let tabBarViewController = MainScreenBuilder.make()
        window.rootViewController = tabBarViewController
        window.makeKeyAndVisible()
    }
}
