//
//   Candle.swift
//  cost of goods
//
//  Created by Андрей Беседин on 03.08.2025.
//

import Foundation

struct Candle {
    var id = UUID()
    var name: String
    var type: String
    var waxVolume: Double // объем воска в граммах
    var waxPricePerKg: Double // цена воска за 1 кг
    var aromaPercentage: Double // процент ароматизатора
    var aromaPricePer100g: Double // цена ароматизатора за 100г
    var containerType: String
    var containerPrice: Double
    var wickType: String
    var wickPrice: Double
    var additionalCosts: Double
    
    // вычисляемые свойства
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
}
