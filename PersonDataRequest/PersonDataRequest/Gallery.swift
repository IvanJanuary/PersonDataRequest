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
    var regularUrl: String
    
    init(image: UIImage, regularUrl: String) {
        self.image = image
        self.regularUrl = regularUrl
    }
}

class Gallery {
    
    var pictures = [Picture]()
    
    init() {
        setup()
    }
    
    func setup() {
        let img1 = Picture(image: UIImage(), regularUrl: "")
        let img2 = Picture(image: UIImage(), regularUrl: "")
        let img3 = Picture(image: UIImage(), regularUrl: "")
        let img4 = Picture(image: UIImage(), regularUrl: "")
        let img5 = Picture(image: UIImage(), regularUrl: "")
        self.pictures = [img1, img2, img3, img4, img5]
    }
}
