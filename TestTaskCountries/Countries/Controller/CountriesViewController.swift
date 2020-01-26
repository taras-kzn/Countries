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
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        config()
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        sender.endRefreshing()
        countriesService.getCountries() { [weak self]  in
            self?.loadData()
            self?.tableView.reloadData()
        }
    }
    
    private func config() {
        
        tableView.refreshControl = myRefreshControl
        tableView.register(UINib(nibName: "CountriesTableViewCell", bundle: nil), forCellReuseIdentifier: CountriesTableViewCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationItem.title = "Страны"
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Avenir", size: 17)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        
        if Connectivity.isConnectedToInternet() {
            countriesService.getCountries() { [weak self]  in
                self?.loadData()
                //self?.array = array
                self?.tableView.reloadData()
            }
        } else {
            loadData()
        }
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
    
    func loadImage(cell: CountriesTableViewCell, url: String?) {
        guard let url = url else { return }
        
        countriesService.downloadImage(url: url) { image in
            DispatchQueue.main.async {
                if let image = image {
                    cell.setImage(image: image)
                } else {
                    guard let image = UIImage(named: "no_image") else {return}
                    cell.setImage(image: image)
                }
            }
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
//        print(countries.images)
//        for i in countries.image {
//            print(i)
//        }
        loadImage(cell: cell, url: countries.flag)

        return cell
    }
}


