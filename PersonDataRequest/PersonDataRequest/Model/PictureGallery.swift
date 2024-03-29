//
//  PictureGallery.swift
//  PersonDataRequest
//
//  Created by Ivan on 14.03.2024.
//

import Foundation

struct PictureGallery: Decodable {
    
    var results: [GalleryUrl]
}

struct GalleryUrl: Decodable {
    
    var urls: PictureUrl
}

struct PictureUrl: Decodable {
    
    var small: String
    var regular: String
}
