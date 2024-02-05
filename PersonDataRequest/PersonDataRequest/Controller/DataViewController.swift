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

                
        guard let genderUrl = URL(string: genderUrl) else { return }
        let genderTask = URLSession.shared.dataTask(with: genderUrl) { (data, response, error) in
            
            guard let data = data else { return }
            
            if let error = error {
                print("Gender request error: \(error.localizedDescription)")
                return
            }
            
            do {
                let genderData = try JSONDecoder().decode(GenderData.self, from: data)
                DispatchQueue.main.async {
                    self.genderUpdateUI(with: genderData)
                }
            } catch {
                print("Decoding error JSON grnder: \(error)")
            }
        }
        
        genderTask.resume()
        
        guard let ageUrl = URL(string: ageUrl) else { return }
        let ageTask = URLSession.shared.dataTask(with: ageUrl) { (data, response, error) in
        
            guard let data = data else { return }

            if let error = error {
                print("Age request error: \(error.localizedDescription)")
                return
            }

            do {
                let ageData = try JSONDecoder().decode(AgeData.self, from: data)
                print("Received age data: \(ageData)") // this row can be removed
                DispatchQueue.main.async {
                    self.ageUpdateUI(with: ageData)
                }
            } catch {
                print("Decoding error JSON age: \(error)")
            }
        }
        
        ageTask.resume()
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
        
//        guard let age = ageData.age else {
//            ageLabel.text = "Age unknown"
//            return
//            }
//            ageLabel.text = String(format: "Age: %d", age)
            

//      ageLabel.text = String(format: "Age: %d", ageData.age ?? 0)  Не всегда есть default value, поэтому не всегда мжно его использовать
        
        
//        if ageData.age != nil {
//            ageLabel.text = String(format: "Age: %d", ageData.age ?? 0)
//        }
        
        

    }
}
        
    
