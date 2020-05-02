//
//  Scene.swift
//  Scenic
//
//  Created by Sam Dean on 23/04/2020.
//  Copyright © 2020 Pink News. All rights reserved.
//

import Foundation
import UIKit

/// A `Scene` is a type used to create and configure a view controller
public protocol Scene {

    /// A `Scene` wraps a single view controller type. It can make others internally, but when used by a `SceneFactory`
    /// this is the controller type returned.
    associatedtype ViewControllerType: UIViewController

    /// The scene factory context type
    associatedtype FactoryContext

    /// Implement this to return a new instance of the view controller representing this scene.
    ///
    /// - note: If the view controller type implements `StoryboardInstantiable` then this method is automatically
    /// implemented to return the controller from a storyboard named the same as this Scene type.
    ///
    /// - returns: A new, unconfigured, instance of this `Scene`'s controller type
    func createViewController() -> ViewControllerType

    /// Implement this to configure your view controller i.e. set it's view model if it's MVVM etc.
    ///
    /// - parameter controller: The controller to configure
    /// - parameter factory: The factory doing the configuring
    /// - parameter context: The context from which to extract useful models / values
    func configure(controller: ViewControllerType, using factory: SceneFactory<FactoryContext>, context: FactoryContext)
}

extension Scene where ViewControllerType: StoryboardInstantiable {

    /// Returns this type's name, with all the namespacing removed.
    ///
    /// i.e. a `Scene` type named `MyApp.MyScene` will return `"MyScene"`.
    private var sceneName: String {
        String(describing: type(of: self)).components(separatedBy: ".").last!
    }

    /// Attempt to load the controller from a storyboard with the same name as this `Scene` instance from the specified
    /// bundle.
    func createViewControllerFromSceneStoryboard(in bundle: Bundle?) -> ViewControllerType {
        ViewControllerType.instantiateFromStoryboard(named: self.sceneName, bundle: bundle)
    }

    /// Attempt to load the controller from a storyboard with the same name as this `Scene` instance.
    ///
    /// If the view controller type is `StoryboardInstantiable` then we can just use that to implement
    /// `createViewController()` for the `Scene`.
    public func createViewController() -> ViewControllerType {
        self.createViewControllerFromSceneStoryboard(in: nil)
    }
}
