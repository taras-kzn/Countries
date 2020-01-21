//
//  CountriesViewController.swift
//  TestTaskCountries
//
//  Created by admin on 19.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift

class CountriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    let countriesService = CountriesService()
    var array = [Countries]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CountriesTableViewCell", bundle: nil), forCellReuseIdentifier: CountriesTableViewCell.reuseId)
        
        countriesService.getCountries() { [weak self]  in
            self?.loadData()
            //self?.array = array
            self?.tableView.reloadData()
        }

        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func loadData() {
        do {
            let realm = try Realm()
            
            let array = realm.objects(Countries.self)
            self.array = Array(array)
            
        } catch {
            print(error)
        }
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.reuseId, for: indexPath) as! CountriesTableViewCell
        let countries = array[indexPath.row]
        cell.cityLabel.text = countries.city
        cell.countryLabel.text = countries.nameCountry
        cell.infoLabel.text = countries.descriptionSmall
        let queue = DispatchQueue.global(qos: .utility)
        //print(countries.image)
        let image = URL(string: countries.flag)
        queue.async {
            if let data = try? Data(contentsOf: image as! URL) {
                DispatchQueue.main.async {
                    cell.iconImageView.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
}


