//
//  DetailViewController.swift
//  TestTaskCountries
//
//  Created by admin on 27.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, Storyboarded {
    //MARK: - IBOutlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var capitalLabel: UILabel!
    @IBOutlet private weak var pageController: UIPageControl!{
        willSet {
            newValue.hidesForSinglePage = true
        }
    }
    @IBOutlet private weak var populationLabel: UILabel!
    @IBOutlet private weak var continentLabel: UILabel!
    //MARK: - Properties
    weak var coordinator: MainCoordinators?
    private let countryService = CountriesService()
    var country: Countries?
    private var arrayImages = [UIImage]() {
        willSet {
            pageController.numberOfPages = newValue.count
            collectionView.reloadData()
        }
    }
    private let colletionNibName = "DetailViewCell"
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup(country: country)
        
    }
    //MARK: - Private Functions
    private func setup(country: Countries?) {
        
        collectionView.register(UINib(nibName: colletionNibName,
                                      bundle: nil),
                                forCellWithReuseIdentifier: DetailViewCell.reuseId)
        collectionView.dataSource = self
        collectionView.delegate = self
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
        
        guard let country = country else {return}
        
        countryLabel.text = country.nameCountry
        descriptionLabel.text = country.info
        populationLabel.text = String(country.population)
        continentLabel.text = country.continent
        capitalLabel.text = country.city
        
        if !country.images.isEmpty {
            print(country.images)
            country.images.forEach { url in
                print(url)
                countryService.downloadImage(url: url) { [weak self] image in
                    guard let image = image else {return}
                    self?.arrayImages.append(image)
                }
            }
        } else {
            let flagUrl = country.flag
            countryService.downloadImage(url: flagUrl) { [weak self] image in
                guard let image = image else {return}
                self?.arrayImages.append(image)
            }
        }
    }
    
    private func loadImages(cell: DetailViewCell ,url: String?) {
        guard let url = url else {return}
        
        countryService.downloadImage(url: url) { image in
            DispatchQueue.main.async {
                if let image = image {
                    cell.setImage(image: image)
                } else {
                    let noImage = "no_image"
                    guard let image = UIImage(named: noImage) else {return}
                    cell.setImage(image: image)
                }
            }
        }
    }
}
//MARK: - CollectionViewDataSource
extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailViewCell.reuseId, for: indexPath) as? DetailViewCell
        guard let cell = cellectionCell else {
            return UICollectionViewCell()
        }
        let images = arrayImages[indexPath.row]
        cell.setImage(image: images)
        
        return cell
    }
}
//MARK: - CollectionViewDelegate
extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        pageController.currentPage = indexPath.row
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         pageController.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
     }   
}
//MARK: - CollectionViewDelegateFlowLayout
extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
