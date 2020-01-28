//
//  CountriesService.swift
//  TestTaskCountries
//
//  Created by admin on 19.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
import RealmSwift


class CountriesService {
    
    private let sessionManager: SessionManager
    
    required init(sessionManager: SessionManager = SessionManager.default) {
        self.sessionManager = sessionManager
    }
    
    let baseUrl = "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888"
    
    func getCountries(completion: @escaping () -> Void) {
        
        let path = "/page1.json"
        let url = baseUrl + path
        
        Alamofire.request(url, method: .get).responseData { response in
            guard let data = response.value else { return }
            let countries = try? JSONDecoder().decode(CountryResponse.self, from: data).countries
            let next = try? JSONDecoder().decode(CountryResponse.self, from: data).next
            guard let url2 = next else {return}
            
            Alamofire.request(url2, method: .get).responseData { response in
                guard let data = response.value else { return }
                let countries2 = try? JSONDecoder().decode(CountryResponse.self, from: data).countries
                guard var array = countries else { return }
                guard var array2 = countries2 else { return }
                
                for i in array2 {
                    array.append(i)
                }
                self.saveCountriesData(array)
                completion()
            }
        }
    }
    
    func downloadImage(url: String, completion: @escaping(UIImage?) -> Void ) {

        Alamofire.request(url).responseData { response in
            guard let data = response.value else { return completion(nil) }
            let image = UIImage(data: data)
            completion(image)
        }
    }
    
    func saveCountriesData(_ countries: [Countries]) {
        
        do {
            let realm = try Realm()
            print(realm.configuration.fileURL)
            let oldCountries = realm.objects(Countries.self)
            realm.beginWrite()
            realm.delete(oldCountries)
            realm.add(countries)
            try realm.commitWrite()
        } catch  {
            print(error)
        }
    }
}

