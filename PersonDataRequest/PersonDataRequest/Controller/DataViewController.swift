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
    let apiHelper = ApiHelper()
    
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
        let pictureGalleryUrl = "https://api.unsplash.com/search/photos?query=nature&client_id=HgIp9aycssr9xW_6xUKmzPyt73ku6HhcgAapLQp664o&per_page=5"
        
        apiHelper.makeRequest(urlString: genderUrl, t: GenderData.self) { [weak self] result in
            self?.handleRequestResult(result)
        }
        
        apiHelper.makeRequest(urlString: ageUrl, t: AgeData.self) { [weak self] result in
            self?.handleRequestResult(result)
        }
        
        apiHelper.makeRequest(urlString: activityUrl, t: ActivityData.self) { [weak self] result in
            self?.handleRequestResult(result)
        }
        
        apiHelper.makeRequest(urlString: pictureGalleryUrl, t: PictureGallery.self) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data else { return }
                self?.loadPictures(data)
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.errorAlert(with: error, completion: { [weak self] in
                        self?.queryUserData()
                    })
                }
            }
        }
    }
    
    func loadPictures(_ pictureGallery: PictureGallery) {
        for i in 0..<5 {
            if pictureGallery.results.indices.contains(i) {
                let item = pictureGallery.results[i]
                let pictureUrl = item.urls.small
                let bigPictureURL = item.urls.regular
                
                apiHelper.makePictureRequest(pictureUrl: pictureUrl) { [weak self] result in
                    switch result {
                    case .success(let imageData):
                        DispatchQueue.main.async {
                            self?.gallery.pictures[i].image = UIImage(data: imageData) ?? UIImage()
                            self?.gallery.pictures[i].regularUrl = bigPictureURL
                            self?.collectionView.reloadData()
                        }
                    case .failure(let error):
                        print("Error loading picture: \(error)")
                    }
                }
            }
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
                 self.errorAlert(with: error) { [weak self] in
                     self?.queryUserData()
                 }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPicture = gallery.pictures[indexPath.item]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        
        detailViewController.regularURL = selectedPicture.regularUrl
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
