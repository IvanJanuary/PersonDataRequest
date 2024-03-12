//
//  PictureCell.swift
//  PersonDataRequest
//
//  Created by Ivan on 03.03.2024.
//

import UIKit

class PictureCell: UICollectionViewCell {
    
    @IBOutlet weak var imageGallery: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageGallery.image = nil
    }
    
    func setupCell(picture: Picture) {
        self.imageGallery.image = picture.image
    }
}
