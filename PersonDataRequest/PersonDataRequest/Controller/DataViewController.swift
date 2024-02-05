//
//  DataViewController.swift
//  PersonDataRequest
//
//  Created by Ivan on 25.01.2024.
//

import UIKit

class DataViewController: UIViewController {
    
    var selectedName: String?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var probabilityLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = selectedName
        
        
    }
    
    
}
        
    
