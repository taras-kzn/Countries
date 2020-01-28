//
//  CountryResponse.swift
//  TestTaskCountries
//
//  Created by admin on 28.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

public class CountryResponse: Decodable {
    
    public var next = ""
    public var countries : [Countries] = []
    
    private enum CodingKeys: String, CodingKey {
        case next
    }
    
    private enum CountryKeys: String, CodingKey {
        case countries
    }
    
    convenience required public init(from decoder: Decoder) throws {
        self.init()
        let values = try? decoder.container(keyedBy: CodingKeys.self)
        self.next = try values?.decode(String.self, forKey: .next) ?? ""
        let arrayValues = try? decoder.container(keyedBy: CountryKeys.self)
        self.countries = try arrayValues?.decode([Countries].self, forKey: .countries) ?? []
    }
}
