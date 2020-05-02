//
//  SceneFactory.swift
//  Scenic
//
//  Created by Sam Dean on 23/04/2020.
//  Copyright © 2020 Pink News. All rights reserved.
//

import Foundation
import UIKit

public struct SceneFactory<FactoryContext> {

    /// This is deliberately private - it's only ever exposed during the creation of `Scene`s.
    private let context: FactoryContext

    public init(context: FactoryContext) {
        self.context = context
    }

    /// Takes a `Scene` instance, creates its view controller and then calls configure with the model objects
    /// (in the FactoryContext). The `Scene` should take the model objects it requires,
    /// but _shouldn't_ keep hold of the context.
    public func createViewController<SceneType: Scene>(_ scene: SceneType) -> SceneType.ViewControllerType
        where SceneType.FactoryContext == FactoryContext {

        let controller = scene.createViewController()

        scene.configure(controller: controller, using: self, context: self.context)

        return controller
    }
}
