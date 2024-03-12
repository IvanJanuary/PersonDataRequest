//
//  DataViewController.swift
//  PersonDataRequest
//
//  Created by Ivan on 25.01.2024.
//

import UIKit

class DataViewController: UIViewController {
    
    var selectedName: String?
    
    var gallery: Gallery = Gallery()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
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
            self?.handleRequestResult(result)
        }
        
        apiHelper.makeRequest(urlString: ageUrl, t: AgeData.self) { [weak self] result in
            self?.handleRequestResult(result)
        }
        
        apiHelper.makeRequest(urlString: activityUrl, t: ActivityData.self) { [weak self] result in
            self?.handleRequestResult(result)
        }
    }
    
    func handleRequestResult<T: Decodable>(_ result: Result<T?, Error>) where T: StringRepresentable {
         switch result {
         case .success(let data):
             guard let data = data else { return }
             DispatchQueue.main.async {
                 self.updateUI(data: data)
             }
         case .failure(let error):
             DispatchQueue.main.async {
                 self.errorAlert(with: error)
             }
         }
     }
    
    func updateUI<T: StringRepresentable>(data: T) {
        switch data.self {
        case is AgeData:
            ageLabel.text = data.stringRepresentation
        case is GenderData:
            genderLabel.text = data.stringRepresentation
        case is ActivityData:
            activityLabel.text = data.stringRepresentation
        default:
            return
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
}
        
extension DataViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gallery.pictures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureCell", for: indexPath) as? PictureCell else { return UICollectionViewCell() }
        
        let picture = gallery.pictures[indexPath.item]
        cell.setupCell(picture: picture)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 150)
    }
    
    
    
}
