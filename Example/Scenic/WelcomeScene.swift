//
//  WelcomeScene.swift
//  Scenic_Example
//
//  Created by Sam Dean on 27/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

import Scenic

struct WelcomeScene: Scene {

    func configure(controller: WelcomeViewController,
                   using factory: SceneFactory<ApplicationContext>,
                   context: ApplicationContext) {

        let router = WelcomeRouter(controller: controller, factory: factory)
        let viewModel = WelcomeViewModel(router: router)

        controller.viewModel = viewModel
    }
}
