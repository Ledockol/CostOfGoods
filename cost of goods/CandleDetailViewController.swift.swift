//
//  CandleDetailViewController.swift.swift
//  cost of goods
//
//  Created by Андрей Беседин on 06.08.2025.
//

import UIKit

class CandleDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var waxVolumeLabel: UILabel!
    @IBOutlet weak var waxPriceLabel: UILabel!
    @IBOutlet weak var aromaPercentageLabel: UILabel!
    @IBOutlet weak var aromaVolume: UILabel!
    @IBOutlet weak var aromaPriceLabel: UILabel!
    @IBOutlet weak var containerTypeLabel: UILabel!
    @IBOutlet weak var containerPriceLabel: UILabel!
    @IBOutlet weak var wickTypeLabel: UILabel!
    @IBOutlet weak var wickPriceLabel: UILabel!
    @IBOutlet weak var additionalCostsLabel: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    var candle: Candle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Добавляем заголовок в Navigation Bar
        navigationItem.title = "Карточка свечи"
        
        guard candle != nil else {
            print("Свеча не передана")
            navigationController?.popViewController(animated: true)
            return
        }
        
        // Заполняем поля данными свечи
        nameLabel.text = "Название: \(candle.name)"
        typeLabel.text = "Тип: \(candle.type)"
        waxVolumeLabel.text = "Объем воска: \(candle.waxVolume) г"
        waxPriceLabel.text = "Цена воска: \(candle.waxPricePerKg) ₽/кг"
        aromaPercentageLabel.text = "Процент ароматизатора: \(candle.aromaPercentage)%"
        aromaVolume.text = "Объем ароматизатора: \(candle.aromaVolume)"
        aromaPriceLabel.text = "Цена ароматизатора: \(candle.aromaPricePer100g) ₽/100г"
        containerTypeLabel.text = "Тип контейнера: \(candle.containerType)"
        containerPriceLabel.text = "Цена контейнера: \(candle.containerPrice) ₽"
        wickTypeLabel.text = "Тип фитиля: \(candle.wickType)"
        wickPriceLabel.text = "Цена фитиля: \(candle.wickPrice) ₽"
        additionalCostsLabel.text = "Дополнительные расходы: \(candle.additionalCosts) ₽"
        cost.text = "Себестоимость: \(candle.cost)"
        commentTextView.text = "Комментарий: \(candle.comment)"
    }
}
