//
//  CandleDetailViewController.swift.swift
//  cost of goods
//
//  Created by Андрей Беседин on 06.08.2025.
//

import UIKit

class CandleDetailViewController: UIViewController, CandleUpdatedDelegate {
    
    // Outlets для отображения информации
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
    
    
    
    // Слабая ссылка на делегат
    weak var delegate: CandleUpdatedDelegate?
    
    // Модель данных
    var candle: Candle!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Инициализация UI
        updateCandleDetails()
        
        
        // Настройка заголовка
        navigationItem.title = "Карточка свечи"
        
        // Проверка наличия данных
        guard candle != nil else {
            print("Свеча не передана")
            navigationController?.popViewController(animated: true)
            return
        }
        
        
    }
    
    
    // Обновление данных на экране
    func updateCandleDetails() {
        nameLabel.text = "Название: \(candle.name)"
        typeLabel.text = "Тип: \(candle.type)"
        waxVolumeLabel.text = String(format: "Объем воска: %.2f г", candle.waxVolume)
        waxPriceLabel.text = String(format: "Цена воска: %.2f ₽/кг", candle.waxPricePerKg)
        aromaPercentageLabel.text = String(format: "Процент ароматизатора: %.2f%%", candle.aromaPercentage)
        aromaVolume.text = String(format: "Объем ароматизатора: %.2f г", candle.aromaVolume)
        aromaPriceLabel.text = String(format: "Цена ароматизатора: %.2f ₽/100г", candle.aromaPricePer100g)
        containerTypeLabel.text = "Тип контейнера: \(candle.containerType)"
        containerPriceLabel.text = String(format: "Цена контейнера: %.2f ₽", candle.containerPrice)
        wickTypeLabel.text = "Тип фитиля: \(candle.wickType)"
        wickPriceLabel.text = String(format: "Цена фитиля: %.2f ₽", candle.wickPrice)
        additionalCostsLabel.text = String(format: "Доп. расходы: %.2f ₽", candle.additionalCosts)
        cost.text = String(format: "Себестоимость: %.2f ₽", candle.cost)
        commentTextView.text = "Комментарий: \(candle.comment)"
    }
    
    // Обработка нажатия кнопки редактирования
    @IBAction func editButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "editCandleSegueCard", sender: candle)
    }
    
    // Подготовка к переходу
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editCandleSegueCard" {
            guard let destination = segue.destination as? EditCandleViewController,
                  let candle = sender as? Candle else {
                return
            }
            destination.delegate = self
            destination.candle = candle
        }
    }
    func candleDidUpdate(_ candle: Candle) {
        // Обновляем данные в карточке
        self.candle = candle
        updateCandleDetails()
        
        // Уведомляем родительский контроллер об обновлении
        delegate?.candleDidUpdate(candle)
    }
}
    

