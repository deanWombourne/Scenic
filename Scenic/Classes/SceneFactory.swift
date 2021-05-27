//
//  SceneFactory.swift
//  Scenic
//
//  Created by Sam Dean on 23/04/2020.
//  Copyright © 2020 samdeanconsulting. All rights reserved.
//

import Foundation
import UIKit

public protocol SceneFactoryDelegate: AnyObject {

    associatedtype FactoryContext

    func factoryDidCreateScene(_ factory: SceneFactory<FactoryContext>, controller: UIViewController)

    func factoryDidConfigureScene(_ factory: SceneFactory<FactoryContext>, controller: UIViewController)
}

public extension SceneFactoryDelegate {

    func factoryDidCreateScene(_ factory: SceneFactory<FactoryContext>, controller: UIViewController) { }

    func factoryDidConfigureScene(_ factory: SceneFactory<FactoryContext>, controller: UIViewController) { }
}

public final class SceneFactory<FactoryContext> {

    private var informDelegateDidCreateScene: ((UIViewController) -> Void)?
    private var informDelegateDidConfigureScene: ((UIViewController) -> Void)?

    /// This is deliberately private - it's only ever exposed during the creation of `Scene`s.
    private let context: FactoryContext

    public init(context: FactoryContext) {
        self.context = context
    }

    /// Set the delegate for this `SceneFactory`
    ///
    /// - note: This is a method not a property as we need to do some type erasure in here.
    public func setDelegate<DelegateType: SceneFactoryDelegate>(_ delegate: DelegateType) where DelegateType.FactoryContext == FactoryContext {
        self.informDelegateDidCreateScene = { [weak self] controller in
            guard let self = self else { return }
            delegate.factoryDidCreateScene(self, controller: controller)
        }

        self.informDelegateDidConfigureScene = { [weak self] controller in
            guard let self = self else { return }
            delegate.factoryDidConfigureScene(self, controller: controller)
        }
    }

    /// Takes a `Scene` instance, creates its view controller and then calls configure with the model objects
    /// (in the FactoryContext). The `Scene` should take the model objects it requires,
    /// but _shouldn't_ keep hold of the context.
    public func createViewController<SceneType: Scene>(_ scene: SceneType) -> SceneType.ViewControllerType
        where SceneType.FactoryContext == FactoryContext {

        let controller = scene.createViewController()

        self.informDelegateDidCreateScene?(controller)

        scene.configure(controller: controller, using: self, context: self.context)

        self.informDelegateDidConfigureScene?(controller)

        return controller
    }
}
