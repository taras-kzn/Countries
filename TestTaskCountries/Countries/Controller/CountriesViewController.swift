//
//  CountriesViewController.swift
//  TestTaskCountries
//
//  Created by admin on 19.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CountriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    
    let countriesService = CountriesService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "CountriesTableViewCell", bundle: nil), forCellReuseIdentifier: CountriesTableViewCell.reuseId)
        
        countriesService.getCountries()

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension CountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.reuseId, for: indexPath) as! CountriesTableViewCell
        
        return cell
    }
}
