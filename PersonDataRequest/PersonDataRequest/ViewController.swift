//
//  ViewController.swift
//  PersonDataRequest
//
//  Created by Ivan on 22.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    let idCell = "personCell"
    
    var nameArray = ["Andrew", "Daniel", "Frank", "John", "Lawrence",
                               "Martin", "Neil", "Patrick", "Richard", "Steven",
                               "Amanda", "Diana", "Frida", "Jennyfer", "Lindsay",
                               "Martha", "Natalie", "Pamella", "Ruth", "Scarlett"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
}
    
extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        if let nameCell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? NameTableViewCell {
//            nameCell.titleLabel?.text = "Name"
//            return nameCell
//        } else {
//            return UITableViewCell()
//        }

        guard let nameCell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? NameTableViewCell else {
            return UITableViewCell()
        }
//
        nameCell.titleLabel?.text = nameArray[indexPath.row]
        return nameCell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Names"
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.lightGray
           
           let headerLabel = UILabel()
           headerLabel.translatesAutoresizingMaskIntoConstraints = false
           headerLabel.text = "Names"
           headerLabel.font = UIFont.boldSystemFont(ofSize: 24)
           headerLabel.textColor = UIColor.white
           
           headerView.addSubview(headerLabel)
           
           NSLayoutConstraint.activate([
               headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
//               headerLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
               headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
           ])
           
           return headerView
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50
       }
    
}
    

