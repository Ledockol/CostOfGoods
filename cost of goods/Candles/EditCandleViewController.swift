//
//  EditCandleViewController.swift

import UIKit


class EditCandleViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
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
    
    // Флаг для определения создания новой свечи
        var isNewCandle: Bool = false
    
    // Делегат для уведомления о сохранении
    weak var delegate: CandleUpdatedDelegate?
    
    var candle: Candle!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Устанавливаем contentSize для ScrollView
                contentView.translatesAutoresizingMaskIntoConstraints = false
                scrollView.contentSize = contentView.bounds.size
                
                // Добавляем отступы для прокрутки
                scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                scrollView.scrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // Проверяем, новая ли свеча
        isNewCandle = candle.name == "" && candle.type == ""

               
               // Если новая свеча, меняем заголовок
               if isNewCandle {
                   navigationItem.title = "Новая свеча"
               } else {
                   navigationItem.title = "Редактирование свечи"
               }

        //  Проверка существования candle
          guard candle != nil else {
              print("Свеча не передана")
              navigationController?.popViewController(animated: true)
            return
          }

        // Заполняем поля данными свечи
        nameField.text = candle.name
        typeField.text = candle.type
        waxVolumeField.text = "\(candle.waxVolume)"
        waxPriceField.text = "\(candle.waxPricePerKg)"
        aromaPercentageField.text = "\(candle.aromaPercentage)"
        aromaPriceField.text = "\(candle.aromaPricePer100g)"
        containerTypeField.text = candle.containerType
        containerPriceField.text = "\(candle.containerPrice)"
        wickTypeField.text = candle.wickType
        wickPriceField.text = "\(candle.wickPrice)"
        additionalCostsField.text = "\(candle.additionalCosts)"
        commentView.text = candle.comment
        
        // Настройка клавиатур
        waxVolumeField.keyboardType = .numberPad
        waxPriceField.keyboardType = .numberPad
        aromaPercentageField.keyboardType = .numberPad
        aromaPriceField.keyboardType = .numberPad
        containerPriceField.keyboardType = .numberPad
        wickPriceField.keyboardType = .numberPad
        additionalCostsField.keyboardType = .numberPad
    }
    
    override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            
            // Обновляем contentSize при изменении layout
            scrollView.contentSize = contentView.bounds.size
        }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    // Сохраняем изменения
        candle.name = nameField.text ?? ""
        candle.type = typeField.text ?? ""
        candle.waxVolume = Double(waxVolumeField.text ?? "0") ?? 0
        candle.waxPricePerKg = Double(waxPriceField.text ?? "0") ?? 0
        candle.aromaPercentage = Double(aromaPercentageField.text ?? "0") ?? 0
        candle.aromaPricePer100g = Double(aromaPriceField.text ?? "0") ?? 0
        candle.containerType = containerTypeField.text ?? ""
        candle.containerPrice = Double(containerPriceField.text ?? "0") ?? 0
        candle.wickType = wickTypeField.text ?? ""
        candle.wickPrice = Double(wickPriceField.text ?? "0") ?? 0
        candle.additionalCosts = Double(additionalCostsField.text ?? "0") ?? 0
        candle.comment = commentView.text ?? ""
        
        // Уведомляем делегат об обновлении
        if let delegate = delegate {
            delegate.candleDidUpdate(candle)
        }
        // Возвращаемся назад
        navigationController?.popViewController(animated: true)
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        if isNewCandle {
                    // Если это новая свеча, просто удаляем её из массива
                    delegate?.candleWasCancelled(candle)
                }
    navigationController?.popViewController(animated: true)
    }
}
