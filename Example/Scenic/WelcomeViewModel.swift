//
//  WelcomeViewModel.swift
//  Scenic_Example
//
//  Created by Sam Dean on 27/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

final class WelcomeViewModel {

    let router: WelcomeRouter

    init(router: WelcomeRouter) {
        self.router = router
    }

    // This is just an example - normally there would be more work here :)
    let title = "Welcome"
    let welcomeMessage = "Welcome to Scenic"

    func enterApp() {
        self.router.enterApp()
    }
}
