//
//  ViewController.swift
//  PersonDataRequest
//
//  Created by Ivan on 22.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let idCell = "personCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
    
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if let nCell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? NameTableViewCell {
//            nCell.titleLabel?.text = "Name"
//            return nCell
//        } else {
//            return UITableViewCell()
//        }

        guard let nameCell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? NameTableViewCell else {
            return UITableViewCell()
        }
//
        nameCell.titleLabel?.text = "Name"
        return nameCell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Names"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
}
    

