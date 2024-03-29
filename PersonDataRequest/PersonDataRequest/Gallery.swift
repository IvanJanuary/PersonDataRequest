//
//  Gallery.swift
//  PersonDataRequest
//
//  Created by Ivan on 03.03.2024.
//

import Foundation
import UIKit

class Picture {
    var image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
}

class Gallery {
    
    var pictures = [Picture]()
    
    init() {
        setup()
    }
    
    func setup() {
        let img1 = Picture(image: UIImage())
        let img2 = Picture(image: UIImage())
        let img3 = Picture(image: UIImage())
        let img4 = Picture(image: UIImage())
        let img5 = Picture(image: UIImage())
        self.pictures = [img1, img2, img3, img4, img5]
    }
}
