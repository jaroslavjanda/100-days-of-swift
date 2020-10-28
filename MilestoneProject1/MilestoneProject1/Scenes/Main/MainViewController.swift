//
//  ViewController.swift
//  MilestoneProject1
//
//  Created by Jaroslav Janda on 26/10/2019.
//  Copyright © 2019 Jaroslav Janda. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    static let cellHeight: CGFloat = 60
    static let cellSpacing: CGFloat = 10
    private var countries = [Country]()
    
    //TODO - fix this
    private var countriesStaticNames: [String] = ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
    
    @IBOutlet var tableView: UITableView!
    let cellReuseIdentifier = "cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Flags"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        for country in countriesStaticNames {
            countries.append(Country(name: country, image: UIImage(named: country) === nil ? nil : UIImage(named: country)! ))
        }
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
    
        tableView.delegate = self
        tableView.dataSource = self
        
        setupUI()
    }

    func setupUI() {
        
    }

}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        cell.imageView?.image = countries[indexPath.row].image
        cell.textLabel?.text = countries[indexPath.row].name.uppercased()
        cell.imageView?.layer.borderWidth = 1
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
       
        return cell
    }
    
    
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MainViewController.cellHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil).instantiateInitialViewController() else {
            fatalError("Storyboard unexpectely crashed ")
        }
        guard let viewController = storyboard as? DetailViewController else {
            fatalError("VC unexpectely crashed ")
        }
        
        viewController.country = countries[indexPath.row]
        
        navigationController?.pushViewController(viewController, animated: true)
    }
}



