//
//  Country.swift
//  TestTaskCountries
//
//  Created by admin on 19.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

public class Countries: Object, Decodable {
    //MARK: - Properties
    @objc public dynamic var nameCountry = ""
    @objc public dynamic var continent = ""
    @objc public dynamic var city = ""
    @objc public dynamic var population = 0
    @objc public dynamic var descriptionSmall = ""
    @objc public dynamic var info = ""
    @objc public dynamic var image = ""
    public let images = List<String>()
    @objc public dynamic var flag = ""
    //MARK: - Private enums
    private enum CodingKeys: String, CodingKey {
        case name
        case continent
        case capital
        case population
        case descriptionsmall = "description_small"
        case description
        case image
        case countryinfo = "country_info"
    }

    private enum CountryKeys: String, CodingKey {
        case images
        case flag
    }
    //MARK: - Init
    convenience required public init(from decoder: Decoder) throws {
        self.init()

        if let values = try? decoder.container(keyedBy: CodingKeys.self) {
            self.nameCountry = try values.decode(String.self, forKey: .name)
            self.continent = try values.decode(String.self, forKey: .continent)
            self.city = try values.decode(String.self, forKey: .capital)
            self.population = try values.decode(Int.self, forKey: .population)
            self.descriptionSmall = try values.decode(String.self, forKey: .descriptionsmall)
            self.info = try values.decode(String.self, forKey: .description)
            self.image = try values.decode(String.self, forKey: .image)
            let countryValues = try values.nestedContainer(keyedBy: CountryKeys.self, forKey: .countryinfo)
            let array = try countryValues.decode([String].self, forKey: .images)
            self.images.append(objectsIn: array)
            self.flag = try countryValues.decode(String.self, forKey: .flag)
        }
    }
}



