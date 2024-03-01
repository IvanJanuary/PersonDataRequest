//
//  AgifyData.swift
//  PersonDataRequest
//
//  Created by Ivan on 02.02.2024.
//

import Foundation

struct AgeData: Decodable, StringRepresentable {
    var stringRepresentation: String {
        if let age = age {
            return String(format: "%d", age)
        } else {
            return "Age unknown"
        }
    }
    
    let age: Int?
}
