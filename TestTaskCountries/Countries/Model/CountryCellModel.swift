//
//  CountryCellModel.swift
//  TestTaskCountries
//
//  Created by admin on 19.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct CountryCellModel {
    //MARK: - Propeties
    let name : String
    let capital: String
    let descriptionSmall: String?
}

final class CountryCellmodelFactory {
    //MARK: Function
    static func cellModel(model: Countries) -> CountryCellModel {
        return CountryCellModel(name: model.nameCountry,
                                capital: model.city,
                                descriptionSmall: model.descriptionSmall)
    }
}
