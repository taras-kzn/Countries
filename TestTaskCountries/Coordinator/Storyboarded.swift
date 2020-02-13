//
//  Storyboarded.swift
//  TestTaskCountries
//
//  Created by admin on 06.02.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboarde = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboarde.instantiateViewController(withIdentifier: id) as! Self
    }
}
