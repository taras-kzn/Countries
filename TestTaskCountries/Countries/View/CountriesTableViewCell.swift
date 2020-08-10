//
//  CountriesTableViewCell.swift
//  TestTaskCountries
//
//  Created by admin on 19.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class CountriesTableViewCell: UITableViewCell {
    //MARK: - IBOutlets
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImageView.image = nil
    }
    //MARK: - Functions
    func configure(with cellModel: CountryCellModel) {
        countryLabel.text = cellModel.name
        cityLabel.text = cellModel.capital
        infoLabel.text = cellModel.descriptionSmall
    }
    
    func setImage(image: UIImage) {
        iconImageView.image = image
    }
}
//MARK: - Extension
extension CountriesTableViewCell {
    static var reuseId: String {
        return String(describing: "CountriesTableViewCell")
    }
}
