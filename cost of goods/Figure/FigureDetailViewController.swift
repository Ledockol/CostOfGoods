//
//  FigureDetailViewController.swift
//  cost of goods
//
//  Created by Андрей Беседин on 13.08.2025.
//


import UIKit

class FigureDetailViewController: UIViewController, FigureUpdatedDelegate {
    func figureWasCancelled(_ figure: Figure) {
    
    }
    
    
    // Outlets для отображения информации
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet weak var materialLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var materialPricePerKgLabel: UILabel!
    @IBOutlet weak var additionalCostsLabel: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var commentTextView: UITextView!
    
    
    weak var delegate: FigureUpdatedDelegate?
    var figure: Figure!
    override func viewDidLoad() {
        super.viewDidLoad()
          
        // Инициализация UI
        updateFigureDetails()
        
        // Настройка заголовка
        navigationItem.title = "Карточка фигуры"
        
        // Проверка наличия данных
        guard figure != nil else {
            print("Фигура не передана")
            navigationController?.popViewController(animated: true)
            return
        }
    }

    // Обновление данных на экране
    func updateFigureDetails() {
        nameLabel.text = "Название: \(figure.name)"
        materialLabel.text = "Материал: \( figure.material)"
        weightLabel.text = String(format: "Вес материала: %.2f г", figure.weight)
        materialPricePerKgLabel.text = String(format: "Цена материала: %.2f ₽/кг", figure.materialPricePerKg)
        additionalCostsLabel.text = String(format: "Доп. расходы: %.2f ₽", figure.additionalCosts)
        cost.text = String(format: "Себестоимость: %.2f ₽", figure.cost)
        commentTextView.text = "Комментарий: \(figure.comment)"
    }
    
    // Обработка нажатия кнопки редактирования
    @IBAction func editButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "editFigureSegueCard", sender: figure)
    }
    
    // Подготовка к переходу
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editFigureSegueCard" {
            guard let destination = segue.destination as? EditFigureViewController,
                  let figure = sender as? Figure else {
                return
            }
            destination.delegate = self
            destination.figure = figure
        }
    }
    
    func figureDidUpdate(_ figure: Figure) {
        // Обновляем данные в карточке
        self.figure = figure
        updateFigureDetails()
        // Уведомляем родительский контроллер об обновлении
        delegate?.figureDidUpdate(figure)
    }
}
    

