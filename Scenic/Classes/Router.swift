//
//  Router.swift
//  PinkNews
//
//  Created by Sam Dean on 23/04/2020.
//  Copyright © 2020 Pink News. All rights reserved.
//

import Foundation
import UIKit

open class Router<ViewController: UIViewController, FactoryContext> {

    private(set) var controller: ViewController?
    let factory: SceneFactory<FactoryContext>

    init(controller: ViewController, factory: SceneFactory<FactoryContext>) {
        self.controller = controller
        self.factory = factory
    }
}
