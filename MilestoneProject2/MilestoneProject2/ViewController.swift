//
//  ViewController.swift
//  MilestoneProject2
//
//  Created by Jaroslav Janda on 26/11/2019.
//  Copyright © 2019 Jaroslav Janda. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private var shoppingList = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        navigationItem.rightBarButtonItems = [
                UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addAlert)),
                UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareAlert))
        ]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteAlert))
    }

    @objc func addAlert() {
        let vc = UIAlertController(title: "New Item", message: nil, preferredStyle: .alert)
        
        vc.addTextField { (textField) in
            textField.placeholder = "Write new item here"
        }
        
        vc.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak self, weak vc] _ in
            guard let self = self else {
                return
            }
            guard let inputText = vc?.textFields?[0].text else {return}
            self.addItem(item: inputText)
        } ))
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))

        present(vc, animated: true)
    }
    
    
    @objc func deleteAlert() {
        let vc = UIAlertController(title: "Are you sure", message: "Do you want delete all items?", preferredStyle: .actionSheet)
        vc.addAction(UIAlertAction(title: "Yes delete (\(shoppingList.count)) items", style: .destructive, handler: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.shoppingList.removeAll()
            self.tableView.reloadData()
        }))
        vc.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(vc, animated: true)
    }
    
    @objc func shareAlert() {
        let textToShare = shoppingList.joined(separator: "\n")
        let activity = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        present(activity, animated: true)
    }
    
    func addItem(item: String) {
        shoppingList.insert(item, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .top)
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemToBuy", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}

