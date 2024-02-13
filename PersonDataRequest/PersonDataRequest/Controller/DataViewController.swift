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
        
        netRequest()
    }
    
    func netRequest() {
        guard let selectedName = selectedName else { return }
        let genderUrl = "https://api.genderize.io/?name=\(selectedName)"
        let ageUrl = "https://api.agify.io/?name=\(selectedName)"
        
        let apiHelper = ApiHelper()
        
        apiHelper.makeRequest(urlString: genderUrl, t: GenderData.self) { genderData in
            guard let genderData = genderData else { return }
            DispatchQueue.main.async {
                self.genderUpdateUI(with: genderData)
            }
        }
        
        apiHelper.makeRequest(urlString: ageUrl, t: AgeData.self) { ageData in
            guard let ageData = ageData else { return }
            DispatchQueue.main.async {
                self.ageUpdateUI(with: ageData)
            }
        }
    }
    
    func genderUpdateUI(with genderData: GenderData) {
        genderLabel.text = genderData.gender
        if let probability = genderData.probability {
            probabilityLabel.text = String(format: "Probability: %d%%", probability * 100)
        } else {
            probabilityLabel.text = "Probability unknown"
        }
    }
    
    func ageUpdateUI(with ageData: AgeData) {
        if let age = ageData.age {
            ageLabel.text = String(format: "Age: %d", age)
        } else {
            ageLabel.text = "Age unknown"
        }
    }
}
        
    
