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
        //        let nameCell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? NameTableViewCell
        guard let nameCell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath) as? NameTableViewCell else {
            return UITableViewCell()
        }
        nameCell.titleLabel?.text = nameArray[indexPath.row]
        return nameCell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
    

