//
//  ViewController+storyboard.swift
//  PinkNews
//
//  Created by Sam Dean on 23/04/2020.
//  Copyright © 2020 Pink News. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardInstantiable where Self: UIViewController {

    static func instantiateFromStoryboard(named storyboardName: String, bundle: Bundle?) -> Self
}

extension UIViewController: StoryboardInstantiable {

    static func instantiateFromStoryboard(named storyboardName: String, bundle: Bundle?) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)

        var candidate = storyboard.instantiateInitialViewController()

        if candidate == nil {
            let name = String("\(Self.self)".split(separator: ".").last!)
            outputError("No initial view controller found in", storyboardName,
                        ". Falling back to controller named '\(name)'")
            candidate = storyboard.instantiateViewController(withIdentifier: name)
        }

        guard let controller = candidate as? Self else {
            fatalError("Expected \(Self.self), but found \(type(of: candidate))")
        }

        return controller
    }
}

private var sentErrors: [String] = []

private func outputError(_ message: String...) {
    let message = message.joined(separator: " ")
    guard !sentErrors.contains(message) else { return }
    print(message)
    sentErrors.append(message)
}
