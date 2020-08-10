//
//  DetailViewCell.swift
//  TestTaskCountries
//
//  Created by admin on 27.01.2020.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

final class DetailViewCell: UICollectionViewCell {
    //MARK: - Property
    static let reuseId = "DetailViewCell"
    //MARK: - IBOutlet
    @IBOutlet private weak var imageView: UIImageView!
    //MARK: Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    //MARK: - Function
    func setImage(image: UIImage) {
        imageView.image = image
    }
}
