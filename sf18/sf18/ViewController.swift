//
//  ViewController.swift
//  sf18
//
//  Created by Igor Korovyanskiy on 17.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isViewLoaded {
               print("true")
           } else {
               print("false")
           }
    }

    @IBAction func colourButton(_ sender: Any) {
        textLabel.text = "Кнопка была нажата"
        button.setTitleColor(.green, for: .normal)
    }
    
}

