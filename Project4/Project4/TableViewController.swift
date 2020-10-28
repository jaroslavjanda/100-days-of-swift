//
//  TableViewController.swift
//  Project4
//
//  Created by Jaroslav Janda on 04/11/2019.
//  Copyright © 2019 Jaroslav Janda. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    var websites = ["apple.com", "hackingwithswift.com","google.com","wikipedia.org"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Init")
        title = "Choose website"
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(identifier: "WebView") as? ViewController else {
            return
        }
        vc.websites = websites
        vc.website = websites[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}
