//
//  PersonData.swift
//  PersonDataRequest
//
//  Created by Ivan on 02.02.2024.
//

import Foundation

struct GenderData: Decodable, StringRepresentable {
    var stringRepresentation: String {
        return gender ?? ""
        
        
    }
    
    let gender: String?
    let probability: Int?
}
