//
//  CountriesService.swift
//  TestTaskCountries
//
//  Created by admin on 19.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Alamofire

class CountriesService {
    let baseUrl = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888"
    
    func getCountries() {
        
        let path = "/page1.json"
        
        let url = baseUrl + path
        
        Alamofire.request(url, method: .get).responseJSON { response in
            print(response.value)
        }
    }
}

