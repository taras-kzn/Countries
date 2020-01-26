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

class CountryResponse: Decodable {
    var next = ""
    var countries : [Countries] = []
    
    enum CodingKeys: String, CodingKey {
        case next
    }
    
    enum CountryKeys: String, CodingKey {
        case countries
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        self.next = try values?.decode(String.self, forKey: .next) ?? ""
        let arrayValues = try? decoder.container(keyedBy: CountryKeys.self)
        self.countries = try arrayValues?.decode([Countries].self, forKey: .countries) ?? []
    }
}

class Countries: Object, Decodable {

    @objc dynamic var nameCountry = ""
    @objc dynamic var continent = ""
    @objc dynamic var city = ""
    @objc dynamic var population = 0
    @objc dynamic var descriptionSmall = ""
    @objc dynamic var info = ""
    @objc dynamic var image = ""
    var images: [imageArray] = []
    @objc dynamic var flag = ""

    enum CodingKeys: String, CodingKey {
        case name
        case continent
        case capital
        case population
        case description_small
        case description
        case image
        case country_info
    }

    enum CountryKeys: String, CodingKey {
        case images
        case flag
    }

    convenience required init(from decoder: Decoder) throws {
        self.init()

        let values = try? decoder.container(keyedBy: CodingKeys.self)
        self.nameCountry = try values?.decode(String.self, forKey: .name) ?? ""
        self.continent = try values?.decode(String.self, forKey: .continent) ?? ""
        self.city = try values?.decode(String.self, forKey: .capital) ?? ""
        self.population = try values?.decode(Int.self, forKey: .population) ?? 0
        self.descriptionSmall = try values?.decode(String.self, forKey: .description_small) ?? ""
        self.info = try values?.decode(String.self, forKey: .description) ?? ""
        self.image = try values?.decode(String.self, forKey: .image) ?? ""

        let countryValues = try values?.nestedContainer(keyedBy: CountryKeys.self, forKey: .country_info)
        self.images = try countryValues?.decode([imageArray].self, forKey: .images) ?? []

        self.flag = try countryValues?.decode(String.self, forKey: .flag) ?? ""
    }

//    override static func ignoredProperties() -> [String] {
//           return ["images"]
//    }
}

class imageArray: Object, Decodable {
    @objc dynamic var images = ""
    
    enum CodingKeys: String, CodingKey {
        case images
    }
    
    convenience required init(from decoder: Decoder) throws {
        self.init()
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        self.images = try values?.decode(String.self, forKey: .images) ?? ""
    }
}



