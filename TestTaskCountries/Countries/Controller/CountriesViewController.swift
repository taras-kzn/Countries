//
//  CountriesViewController.swift
//  TestTaskCountries
//
//  Created by admin on 19.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import RealmSwift

final class CountriesViewController: UIViewController, Storyboarded {
    //MARK: - IBOutlet
    @IBOutlet private weak var tableView: UITableView!
    //MARK: - Properties
    var coordinator: MainCoordinators?
    private let tableNibName = "CountriesTableViewCell"
    private let countriesService = CountriesService()
    private var array = [Countries]()
    private let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    //MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        config()
    }
    //MARK: - Private Functions
    @objc private func refresh(sender: UIRefreshControl) {
        sender.endRefreshing()
        countriesService.getCountries() { [weak self]  in
            self?.loadData()
            self?.tableView.reloadData()
        }
    }
    
    private func config() {
        
        tableView.refreshControl = myRefreshControl
        tableView.register(UINib(nibName: tableNibName, bundle: nil), forCellReuseIdentifier: CountriesTableViewCell.reuseId)
        tableView.dataSource = self
        tableView.delegate = self
        let titleNavigation = "Страны"
        let UIFontName = "Avenir"
        self.navigationItem.title = titleNavigation
        let attributes = [NSAttributedString.Key.font: UIFont(name: UIFontName, size: 17)!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
        if Connectivity.isConnectedToInternet() {
            countriesService.getCountries() { [weak self]  in
                self?.loadData()
                self?.tableView.reloadData()
            }
        } else {
            loadData()
        }
    }
    
    private func loadData() {
        do {
            let realm = try Realm()
            
            let array = realm.objects(Countries.self)
            self.array = Array(array)
            
        } catch {
            print(error)
        }
    }
    
    private func loadImage(cell: CountriesTableViewCell, url: String?) {
        
        guard let url = url else { return }
        let noImage = "no_image"
        countriesService.downloadImage(url: url) { image in
            DispatchQueue.main.async {
                if let image = image {
                    cell.setImage(image: image)
                } else {
                    guard let image = UIImage(named: noImage) else {return}
                    cell.setImage(image: image)
                }
            }
        }
    }
}
//MARK: - TableViewDataSource
extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let countriesCell = tableView.dequeueReusableCell(withIdentifier: CountriesTableViewCell.reuseId, for: indexPath) as? CountriesTableViewCell
        guard let cell = countriesCell else {
            return UITableViewCell()
        }
        let countries = array[indexPath.row]
        let cellModel = CountryCellmodelFactory.cellModel(model: countries)
        cell.configure(with: cellModel)
        loadImage(cell: cell, url: countries.flag)

        return cell
    }
}
//MARK: - TableViewDelegate
extension CountriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = self.array[indexPath.row]
        coordinator?.goDetailVC(country: country)
    }
}


