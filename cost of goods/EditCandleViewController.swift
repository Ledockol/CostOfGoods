//
//  EditCandleViewController.swift
//  cost of goods
//
//  Created by Андрей Беседин on 03.08.2025.
//

import UIKit

class EditCandleViewController: UIViewController {
    
    // Outlets для всех текстовых полей
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var typeField: UITextField!
    @IBOutlet weak var waxVolumeField: UITextField!
    @IBOutlet weak var waxPriceField: UITextField!
    @IBOutlet weak var aromaPercentageField: UITextField!
    @IBOutlet weak var aromaPriceField: UITextField!
    @IBOutlet weak var containerTypeField: UITextField!
    @IBOutlet weak var containerPriceField: UITextField!
    @IBOutlet weak var wickTypeField: UITextField!
    @IBOutlet weak var wickPriceField: UITextField!
    @IBOutlet weak var additionalCostsField: UITextField!
    @IBOutlet weak var commentView: UITextView!
    
    var candle: Candle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Настройка навигационной панели
        navigationItem.title = "Редактирование свечи"
        
        // Заполняем поля данными свечи
//        nameField.text = candle.name
//        typeField.text = candle.type
//        waxVolumeField.text = "\(candle.waxVolume)"
//        waxPriceField.text = "\(candle.waxPricePerKg)"
//        aromaPercentageField.text = "\(candle.aromaPercentage)"
//        aromaPriceField.text = "\(candle.aromaPricePer100g)"
//        containerTypeField.text = candle.containerType
//        containerPriceField.text = "\(candle.containerPrice)"
//        wickTypeField.text = candle.wickType
//        wickPriceField.text = "\(candle.wickPrice)"
//        additionalCostsField.text = "\(candle.additionalCosts)"
//        commentView.text = candle.comment
        
        // Настройка клавиатур
        waxVolumeField.keyboardType = .numberPad
        waxPriceField.keyboardType = .numberPad
        aromaPercentageField.keyboardType = .numberPad
        aromaPriceField.keyboardType = .numberPad
        containerPriceField.keyboardType = .numberPad
        wickPriceField.keyboardType = .numberPad
        additionalCostsField.keyboardType = .numberPad
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // Сохраняем изменения
//        candle.name = nameField.text ?? ""
//        candle.type = typeField.text ?? ""
//        candle.waxVolume = Double(waxVolumeField.text ?? "0") ?? 0
//        candle.waxPricePerKg = Double(waxPriceField.text ?? "0") ?? 0
//        candle.aromaPercentage = Double(aromaPercentageField.text ?? "0") ?? 0
//        candle.aromaPricePer100g = Double(aromaPriceField.text ?? "0") ?? 0
//        candle.containerType = containerTypeField.text ?? ""
//        candle.containerPrice = Double(containerPriceField.text ?? "0") ?? 0
//        candle.wickType = wickTypeField.text ?? ""
//        candle.wickPrice = Double(wickPriceField.text ?? "0") ?? 0
//        candle.additionalCosts = Double(additionalCostsField.text ?? "0") ?? 0
//        candle.comment = commentView.text ?? ""
        
        // Возвращаемся назад
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
