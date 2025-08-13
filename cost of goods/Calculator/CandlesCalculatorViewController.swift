import UIKit



//Рассчитаь количество свечей

class CandlesCalculatorViewController: UIViewController {
    @IBOutlet weak var waxTextField: UITextField! //воск в граммах
    @IBOutlet weak var fragranceTextField: UITextField! // ароматизатор
    @IBOutlet weak var fragrancePercentTextField: UITextField! //%
    @IBOutlet weak var candleVolumeTextField: UITextField! //свеча объем
    @IBOutlet weak var resultLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    private func setupTextFields() {
        waxTextField.keyboardType = .numberPad
        fragranceTextField.keyboardType = .numberPad
        fragrancePercentTextField.keyboardType = .numberPad
        candleVolumeTextField.keyboardType = .numberPad
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        guard let wax = Double(waxTextField.text ?? "0"),
              let fragrance = Double(fragranceTextField.text ?? "0"),
              let percent = Double(fragrancePercentTextField.text ?? "0"),
              let volume = Double(candleVolumeTextField.text ?? "0") else {
            showError("Введите корректные числа")
            return
        }
         
        
        let result = calculateCandlesCount(wax: wax, fragrance: fragrance,percent: percent, volume: volume)
        resultLabel.text = "Количество свечей: \(result) шт"
    }
    
    
    private func calculateCandlesCount(wax: Double, fragrance: Double, percent: Double, volume: Double) -> Int {
        
        let candleFragranceVolume = volume * (percent / 100)
        
        guard fragrance >= candleFragranceVolume else {
            showError("Недостаточно ароматизатора!Нужно \(candleFragranceVolume) грамм")
            return 0
        }
        let candleWaxVolume = volume * (1 - percent/100)
        
        guard wax >= candleWaxVolume else {
            showError("Недостаточно воска! Нужно \(candleWaxVolume) грамм")
            return 0
        }
        
        let maxWaxCandles = wax / candleWaxVolume
        let maxFragranceCandles = fragrance / candleFragranceVolume
        
        return min(Int(maxWaxCandles), Int(maxFragranceCandles))
    }
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

