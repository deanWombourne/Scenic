//
//  Router.swift
//  Scenic
//
//  Created by Sam Dean on 23/04/2020.
//  Copyright © 2020 samdeanconsulting. All rights reserved.
//

import Foundation
import UIKit

open class Router<ViewController: UIViewController, FactoryContext> {

    public private(set) weak var controller: ViewController?
    public let factory: SceneFactory<FactoryContext>

    public init(controller: ViewController, factory: SceneFactory<FactoryContext>) {
        self.controller = controller
        self.factory = factory
    }
}

extension Router {

    private func push(_ controller: @autoclosure () -> UIViewController, animated: Bool) -> Bool {
        guard let navigationController = self.controller?.navigationController else { return false }
        navigationController.pushViewController(controller(), animated: animated)
        return true
    }

    /// Push a view controller onto the current view controller's navigation controller
    ///
    /// - parameter animated: _(optional)_ Animate the push, defaults to `true`
    /// - returns: `false` if a navigation controller could not be found. `true` otherwise.
    @discardableResult
    public func pushViewController(_ controller: UIViewController, animated: Bool = true) -> Bool {
        self.push(controller, animated: animated)
    }

    /// Push a scene onto the current view controller's navigation controller
    ///
    /// - parameter animated: _(optional)_ Animate the push, defaults to `true`
    /// - returns: `false` if a navigation controller could not be found. `true` otherwise.
    @discardableResult
    public func pushScene<T: Scene>(_ scene: @autoclosure () -> T, animated: Bool = true) -> Bool where T.FactoryContext == FactoryContext {
        self.push(factory.createViewController(scene()), animated: animated)
    }
}
