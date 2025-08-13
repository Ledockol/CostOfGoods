import UIKit



//Рассчитаь количество свечей

class CandlesCalculatorViewController: UIViewController {
    @IBOutlet weak var waxTextField: UITextField!
    @IBOutlet weak var fragranceTextField: UITextField!
    @IBOutlet weak var fragrancePercentTextField: UITextField!
    @IBOutlet weak var candleVolumeTextField: UITextField!
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
        
        let requiredFragrance = calculateRequiredFragrance(wax: wax, percent: percent)
        
        if fragrance < requiredFragrance {
            showError("Недостаточно ароматизатора! Требуется: \(requiredFragrance) грамм")
            return
        }
        
        if volume > (wax + fragrance) {
            showError("Материала не хватает для свечи")
            return
        }
        
        let result = calculateCandlesCount(wax: wax, fragrance: fragrance, volume: volume)
        resultLabel.text = "Количество свечей: \(result) шт"
    }
    
    private func calculateRequiredFragrance(wax: Double, percent: Double) -> Double {
        return wax * (percent / 100)
    }
    
    private func calculateCandlesCount(wax: Double, fragrance: Double, volume: Double) -> Int {
        let totalMaterial = wax + fragrance
        return Int(totalMaterial / volume)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

