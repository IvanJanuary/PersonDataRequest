//
//  ActivityData.swift
//  PersonDataRequest
//
//  Created by Ivan on 25.02.2024.
//

import Foundation

struct ActivityData: Decodable, StringRepresentable {
    var stringRepresentation: String {
        return activity ?? ""
    }
    
    var activity: String?
    
    
}
