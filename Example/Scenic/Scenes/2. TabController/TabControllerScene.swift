//
//  TabControllerScene.swift
//  Scenic_Example
//
//  Created by Sam Dean on 20/12/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

import Scenic

final class TabControllerScene: Scene {

    func createViewController() -> UITabBarController {
        UITabBarController()
    }

    func configure(controller: UITabBarController, using factory: SceneFactory<ApplicationContext>, context: ApplicationContext) {
        
    }
}
