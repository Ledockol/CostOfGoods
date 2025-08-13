//
//   Candle.swift
//  cost of goods
//
//  Created by Андрей Беседин on 03.08.2025.
//
import Foundation

struct Candle: Encodable, Decodable {
    var id: UUID
    var name: String
    var type: String
    var waxVolume: Double
    var waxPricePerKg: Double
    var aromaPercentage: Double
    var aromaPricePer100g: Double
    var containerType: String
    var containerPrice: Double
    var wickType: String
    var wickPrice: Double
    var additionalCosts: Double
    
  
    var aromaVolume: Double {
        return waxVolume * (aromaPercentage / 100)
    }
    
    var cost: Double {
        return ((waxVolume / 1000) * waxPricePerKg) +
               ((aromaVolume / 100) * aromaPricePer100g) +
               containerPrice +
               wickPrice +
               additionalCosts
    }
    
    var comment: String
    
    init(
        id: UUID = UUID(),
        name: String,
        type: String,
        waxVolume: Double,
        waxPricePerKg: Double,
        aromaPercentage: Double,
        aromaPricePer100g: Double,
        containerType: String,
        containerPrice: Double,
        wickType: String,
        wickPrice: Double,
        additionalCosts: Double,
        comment: String
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.waxVolume = waxVolume
        self.waxPricePerKg = waxPricePerKg
        self.aromaPercentage = aromaPercentage
        self.aromaPricePer100g = aromaPricePer100g
        self.containerType = containerType
        self.containerPrice = containerPrice
        self.wickType = wickType
        self.wickPrice = wickPrice
        self.additionalCosts = additionalCosts
        self.comment = comment
    }
}
