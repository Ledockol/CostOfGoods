



import UIKit


enum CalculatorType {
    case fragranceForWax
    case waxForFragrance
    case candlesCount
}

class CalculatorViewController: UIViewController {
 
    @IBOutlet weak var fragranceForWaxButton: UIButton!
    @IBOutlet weak var waxForFragranceButton: UIButton!
    @IBOutlet weak var candlesCountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

