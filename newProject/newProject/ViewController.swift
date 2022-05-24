//
//  ViewController.swift
//  newProject
//
//  Created by Igor Korovyanskiy on 11.05.2022.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var textOutlet: UILabel!

    var currentScore = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textOutlet.text = "0"
    }
    

    @IBAction func buttonEqual(_ sender: Any) {
        let checkedWorkingsForPercent = currentScore.replacingOccurrences(of: "%", with: "*0.01")
        let expression = NSExpression(format: checkedWorkingsForPercent)
        let results = expression.expressionValue(with: nil, context: nil) as!  Double
        let resultString = formatResult(result: results)
        textOutlet.text = resultString
    }
    func formatResult (result: Double) -> String {
        if(result.truncatingRemainder(dividingBy: 1) == 0)
        {  return String (format: "%.0f", result )
        } else {
            return String (format: "%.2f", result)
        }
    
    }

    @IBAction func buttonComa(_ sender: UIButton) {
        currentScore += "."
        textOutlet.text = currentScore
    }

    @IBAction func button0(_ sender: UIButton) {
        currentScore += "0"
        textOutlet.text = currentScore
    }

    @IBAction func buttonPlus(_ sender: Any) {
        currentScore += "+"
        textOutlet.text = currentScore
    }

    @IBAction func button3(_ sender: UIButton) {
        currentScore += "3"
        textOutlet.text = currentScore
    }

    @IBAction func button2(_ sender: UIButton) {
        currentScore += "2"
        textOutlet.text = currentScore
    }

    @IBAction func button1(_ sender: UIButton) {
        currentScore += "1"
        textOutlet.text = currentScore
    }

    @IBAction func buttonMinus(_ sender: UIButton) {
        currentScore += "-"
        textOutlet.text = currentScore
    }

    @IBAction func button6(_ sender: UIButton) {
        currentScore += "6"
        textOutlet.text = currentScore
    }

    @IBAction func button5(_ sender: UIButton) {
        currentScore += "5"
        textOutlet.text = currentScore
    }

    @IBAction func button4(_ sender: UIButton) {
        currentScore += "4"
        textOutlet.text = currentScore
    }

    @IBAction func buttonMiltiply(_ sender: UIButton) {
        currentScore += "*"
        textOutlet.text = currentScore
    }

    @IBAction func button9(_ sender: UIButton) {
        currentScore += "9"
        textOutlet.text = currentScore
    }

    @IBAction func button8(_ sender: UIButton) {
        currentScore += "8"
        textOutlet.text = currentScore
    }

    @IBAction func button7(_ sender: UIButton) {
        currentScore += "7"
        textOutlet.text = currentScore
    }

    @IBAction func divisionButton(_ sender: UIButton) {
        currentScore += "/"
        textOutlet.text = currentScore
    }

    @IBAction func percentButton(_ sender: UIButton) {
        currentScore += "%"
        textOutlet.text = currentScore
    }

    @IBAction func minusPlusButton(_ sender: UIButton) {
        currentScore = "-" + ""
        textOutlet.text = currentScore
    }

    @IBAction func cleanButton(_ sender: UIButton) {
        currentScore = ""
        textOutlet.text = "0"
    }
}

