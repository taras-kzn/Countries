//
//  Coordinator.swift
//  TestTaskCountries
//
//  Created by admin on 06.02.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    //MARK: - Properties
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    //MARK: - Function
    func start()
}
