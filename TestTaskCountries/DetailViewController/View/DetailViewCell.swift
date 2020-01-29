//
//  DetailViewCell.swift
//  TestTaskCountries
//
//  Created by admin on 27.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class DetailViewCell: UICollectionViewCell {
    
    static let reuseId = "DetailViewCell"
    
    @IBOutlet private weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func setImage(image: UIImage) {
        imageView.image = image
    }
}
