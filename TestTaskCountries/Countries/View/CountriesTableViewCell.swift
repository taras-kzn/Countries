//
//  CountriesTableViewCell.swift
//  TestTaskCountries
//
//  Created by admin on 19.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class CountriesTableViewCell: UITableViewCell {
    
    static let reuseId = "CountriesTableViewCell"

    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var infoLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImageView.image = nil
    }
    
    func configure(with cellModel: CountryCellModel) {
        countryLabel.text = cellModel.name
        cityLabel.text = cellModel.capital
        infoLabel.text = cellModel.descriptionSmall
    }
    
    func setImage(image: UIImage) {
        iconImageView.image = image
    }
}
