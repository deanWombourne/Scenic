//
//  WelcomeViewController.swift
//  Scenic_Example
//
//  Created by Sam Dean on 27/04/2020.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

final class WelcomeViewController: UIViewController {

    @IBOutlet private weak var label: UILabel?

    var viewModel: WelcomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = self.viewModel.title
        self.label?.text = self.viewModel.welcomeMessage
    }

    @IBAction private func buttonDidTouchUpInside(_ button: UIButton!) {
        self.viewModel.enterApp()
    }
}
