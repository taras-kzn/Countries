//
//  CountriesTableViewCell.swift
//  TestTaskCountries
//
//  Created by admin on 19.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class CountriesTableViewCell: UITableViewCell {
    
    static let reuseId = "CountriesTableViewCell"

    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.iconImageView.image = nil
    }
    
    func config(with cellModel: CountryCellModel) {
        countryLabel.text = cellModel.name
        cityLabel.text = cellModel.capital
        infoLabel.text = cellModel.descriptionSmall
    }
    
    func setImage(image: UIImage) {
        iconImageView.image = image
    }
}
