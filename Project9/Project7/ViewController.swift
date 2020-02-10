//
//  ViewController.swift
//  Project7
//
//  Created by Jaroslav Janda on 06/02/2020.
//  Copyright © 2020 Jaroslav Janda. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    var allPetitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        performSelector(inBackground: #selector(loadData), with: nil)
    }
    
    func setupUI() {
        title = "Whitehouse news"
        let credits = UIBarButtonItem(title: "Credits", style: .plain, target: self, action: #selector(creditsTapped))
        let filter = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(filterTapped))
        navigationItem.rightBarButtonItem = credits
        navigationItem.leftBarButtonItem = filter
    }
    
    @objc func creditsTapped() {
        let alert = UIAlertController(title: "About app", message: "Data comes from the We The People API of the Whitehouse.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc func filterTapped() {
        let alert = UIAlertController(title: "Filter", message: "Write keyword and filter news", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Enter keywords"
        }
        let filterAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alert] _ in
            guard let answer = alert?.textFields?[0].text else {
                return
            }
            if (answer.isEmpty) {
                self?.navigationItem.leftBarButtonItem?.title = "Filter"
            } else {
                self?.navigationItem.leftBarButtonItem?.title = "Filtered by \(answer)"
                DispatchQueue.global(qos: .userInitiated).async {
                    self?.filterData(keyword: answer)
                }
            }
            
        }
        
        alert.addAction(filterAction)
        present(alert, animated: true)
    }
    
    @objc func filterData(keyword: String) {
        let filterPetitions = keyword != "" ? allPetitions.filter { $0.body.range(of: keyword, options: .caseInsensitive) != nil } : allPetitions
        petitions = filterPetitions
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    @objc func loadData() {
        let urlString: String
        
        if navigationController?.tabBarItem.tag == 0 {
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        } else {
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        
        if let url = URL(string: urlString) {
            if let data = try? Data(contentsOf: url) {
                parse(json: data)
                return
            }
        }
        performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
    }
    
    
    @objc func showError() {
        DispatchQueue.main.async { [weak self] in
            let ac = UIAlertController(title: "Loading error", message: "Please check your connection and it try again", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(ac, animated: true )
        }
        
        
    }
    
    func parse(json: Data) {
        let decoder = JSONDecoder()
        
        if let jsonPetitions = try? decoder.decode(Petitions.self, from: json) {
            petitions = jsonPetitions.results
            allPetitions = jsonPetitions.results
            tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        } else {
            performSelector(onMainThread: #selector(showError), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = petitions[indexPath.row].title
        cell.detailTextLabel?.text = petitions[indexPath.row].body
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.detailItem = petitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

