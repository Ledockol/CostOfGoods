import UIKit

//Расчитать количество воска для отдушки


class WaxCalculatorViewController: UIViewController {
    @IBOutlet weak var fragranceTextField: UITextField!
    @IBOutlet weak var fragrancePercentTextField: UITextField!
    @IBOutlet weak var resultLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    private func setupTextFields() {
        fragranceTextField.keyboardType = .numberPad
        fragrancePercentTextField.keyboardType = .numberPad
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        guard let fragrance = Double(fragranceTextField.text ?? "0"),
              let percent = Double(fragrancePercentTextField.text ?? "0") else {
            showError("Введите корректные числа")
            return
        }
        
        let result = calculateWax(fragrance: fragrance, percent: percent)
        resultLabel.text = "Необходимое количество воска: \(result) грамм"
    }
    
    private func calculateWax(fragrance: Double, percent: Double) -> Double {
        return (fragrance * 100) / percent
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

