//
//  Gallery.swift
//  PersonDataRequest
//
//  Created by Ivan on 03.03.2024.
//

import Foundation
import UIKit

struct Picture {
    var image: UIImage
}

class Gallery {
    
    var pictures = [Picture]()
    
    init() {
        setup()
    }
    
    func setup() {
        let img1 = Picture(image: UIImage(named: "img1")!)
        let img2 = Picture(image: UIImage(named: "img2")!)
        let img3 = Picture(image: UIImage(named: "img3")!)
        let img4 = Picture(image: UIImage(named: "img4")!)
        let img5 = Picture(image: UIImage(named: "img5")!)
        self.pictures = [img1, img2, img3, img4, img5]
    }
}
