import UIKit


//Расчитать количество ароматизатора для воска


class FragranceCalculatorViewController: UIViewController {
    @IBOutlet weak var waxTextField: UITextField!
    @IBOutlet weak var fragrancePercentTextField: UITextField!
    @IBOutlet weak var resultLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    private func setupTextFields() {
        waxTextField.keyboardType = .numberPad
        fragrancePercentTextField.keyboardType = .numberPad
    }
    
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        guard let wax = Double(waxTextField.text ?? "0"),
              let percent = Double(fragrancePercentTextField.text ?? "0") else {
            showError("Введите корректные числа")
            return
        }
        
        let result = calculateFragrance(wax: wax, percent: percent)
        resultLabel.text = "Необходимое количество ароматизатора: \(result) грамм"
    }
    
    private func calculateFragrance(wax: Double, percent: Double) -> Double {
        return wax * (percent / 100)
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

