//
//  WelcomeRouter.swift
//  Scenic_Example
//
//  Created by Sam Dean on 27/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

import Scenic

final class WelcomeRouter: Router<WelcomeViewController, ApplicationContext> {

    func enterApp() {
        let controller = self.factory.createViewController(TabControllerScene())
        controller.modalPresentationStyle = .fullScreen
        self.controller?.present(controller, animated: true, completion: nil)
    }
}
