//
//  MainCoordinators.swift
//  TestTaskCountries
//
//  Created by admin on 06.02.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinators: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = CountriesViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goDetailVC(country: Countries) {
        let vc = DetailViewController.instantiate()
        vc.country = country
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
}
