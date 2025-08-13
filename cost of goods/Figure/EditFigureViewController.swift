//
//  EditFigureViewController.swift
//  cost of goods
//
//  Created by Андрей Беседин on 13.08.2025.
//


import UIKit


class EditFigureViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    

    @IBOutlet var nameField: UITextField!
    @IBOutlet weak var materialField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var materialPricePerKgField: UITextField!
    @IBOutlet weak var additionalCostsField: UITextField!
    @IBOutlet weak var commentView: UITextView!
    
    // Флаг для определения создания новой фигуры
        var isNewFigure: Bool = false
    
    // Делегат для уведомления о сохранении
    weak var delegate: FigureUpdatedDelegate?
    
    var figure: Figure!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Устанавливаем contentSize для ScrollView
                contentView.translatesAutoresizingMaskIntoConstraints = false
                scrollView.contentSize = contentView.bounds.size
                
                // Добавляем отступы для прокрутки
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Проверяем, новая ли фигура
        isNewFigure = figure.name == "" && figure.material == ""

               
               // Если новая фигура, меняем заголовок
               if isNewFigure {
                   navigationItem.title = "Новая фигура"
               } else {
                   navigationItem.title = "Редактирование фигуры"
               }

    
          guard figure != nil else {
              print("Фигура не передана")
              navigationController?.popViewController(animated: true)
            return
          }

        // Заполняем поля данными фигуры
        nameField.text = figure.name
        materialField.text = figure.material
        weightField.text = "\(figure.weight)"
        materialPricePerKgField.text = "\(figure.materialPricePerKg)"
        additionalCostsField.text = "\(figure.additionalCosts)"
        commentView.text = figure.comment

        // Настройка клавиатур
        weightField.keyboardType = .numberPad
        materialPricePerKgField.keyboardType = .numberPad
        additionalCostsField.keyboardType = .numberPad
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            // Обновляем contentSize при изменении layout
            scrollView.contentSize = contentView.bounds.size
        }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
//    // Сохраняем изменения
        figure.name = nameField.text ?? ""
        figure.material = materialField.text ?? ""
        figure.weight = Double(weightField.text ?? "0") ?? 0
        figure.materialPricePerKg = Double(materialPricePerKgField.text ?? "0") ?? 0
        figure.additionalCosts = Double(additionalCostsField.text ?? "0") ?? 0
        figure.comment = commentView.text ?? ""

        // Уведомляем делегат об обновлении
        if let delegate = delegate {
            delegate.figureDidUpdate(figure)
        }
        // Возвращаемся назад
        navigationController?.popViewController(animated: true)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        if isNewFigure {
                    // Если это новая фигура - удаляем
                    delegate?.figureWasCancelled(figure)
                }
    navigationController?.popViewController(animated: true)
    }
}
