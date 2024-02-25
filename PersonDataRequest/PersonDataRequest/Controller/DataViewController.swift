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
    @IBOutlet weak var activityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = selectedName
        
        queryUserData()
    }
    
    func queryUserData() {
        guard let selectedName = selectedName else { return }
        let genderUrl = "https://api.genderize.io/?name=\(selectedName)"
        let ageUrl = "https://api.agify.io/?name=\(selectedName)"
        let activityUrl = "https://www.boredapi.com/api/activity/"
        
        let apiHelper = ApiHelper()
        
        apiHelper.makeRequest(urlString: genderUrl, t: GenderData.self) { [weak self] result in
            switch result {
            case .success(let genderData):
                guard let genderData = genderData else { return }
                DispatchQueue.main.async {
                    self?.genderUpdateUI(with: genderData )
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorAlert(with: error )
                }
            }
        }
        
        apiHelper.makeRequest(urlString: ageUrl, t: AgeData.self) { [weak self] result in
            switch result {
            case .success(let ageData):
                guard let ageData = ageData else { return }
                DispatchQueue.main.async {
                    self?.ageUpdateUI(with: ageData)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorAlert(with: error)
                }
            }
        }
        
        apiHelper.makeRequest(urlString: activityUrl, t: ActivityData.self) { [weak self] result in
            switch result {
            case .success(let activityData):
                guard let activityData = activityData else { return }
                DispatchQueue.main.async {
                    self?.activityUpdateUI(with: activityData)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorAlert(with: error)
                }
            }
        }
    }
    
    func errorAlert(with error: Error) {
        let alert = UIAlertController(title: "Error!", message: "Your error: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { [weak self] (_: UIAlertAction!) in
            self?.queryUserData()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    func genderUpdateUI(with genderData: GenderData) {
        genderLabel.text = genderData.gender
        if let probability = genderData.probability {
            probabilityLabel.text = String(format: "%d%%", probability * 100)
        } else {
            probabilityLabel.text = "Probability unknown"
        }
    }
    
    func ageUpdateUI(with ageData: AgeData) {
        if let age = ageData.age {
            ageLabel.text = String(format: "%d", age)
        } else {
            ageLabel.text = "Age unknown"
        }
    }
    
    func activityUpdateUI(with activity: ActivityData) {
        activityLabel.text = "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it's seen all around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum. Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book. It usually begins with The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it's seen all around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum"
    }
}
        
    
