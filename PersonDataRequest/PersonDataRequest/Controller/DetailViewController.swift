//
//  DetailViewController.swift
//  PersonDataRequest
//
//  Created by Ivan on 30.03.2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var apiHelper = ApiHelper()
    
    @IBOutlet weak var imageView: UIImageView!
    var regularURL: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let regularURL = regularURL {
            apiHelper.makePictureRequest(pictureUrl: regularURL) { [weak self] result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        self?.imageView.image = UIImage(data: data)
                    }
                 
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.errorAlert(with: error, completion: {})
                    }
                }
            }
        }
    }
}

extension UIViewController {
    func errorAlert(with error: Error, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: "Error!", message: "Your error: \(error.localizedDescription)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
        }))
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { (_: UIAlertAction!) in
            completion()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

