//
//  Figure.swift
//  cost of goods
//
//  Created by Андрей Беседин on 12.08.2025.
//

import Foundation

struct Figure: Encodable, Decodable {  
    var id: UUID
    var name: String
    var material: String
    var weight: Double
    var materialPricePerKg: Double
    var additionalCosts: Double
    
    var cost: Double {
        return ((weight / 1000) * materialPricePerKg) + additionalCosts
    }
    
    var comment: String
    
    init(
        id: UUID = UUID(),
        name: String,
        material: String,
        weight: Double,
        materialPricePerKg: Double,
        additionalCosts: Double,
        comment: String
    ) {
        self.id = id
        self.name = name
        self.material = material
        self.weight = weight
        self.materialPricePerKg = materialPricePerKg
        self.additionalCosts = additionalCosts
        self.comment = comment
    }
}
