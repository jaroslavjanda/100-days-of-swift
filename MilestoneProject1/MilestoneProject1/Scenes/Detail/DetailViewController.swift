//
//  DetailViewController.swift
//  MilestoneProject1
//
//  Created by Jaroslav Janda on 26/10/2019.
//  Copyright © 2019 Jaroslav Janda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var country: Country?
    
    @IBOutlet weak var flagImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         navigationController?.hidesBarsOnTap = true
     }
     
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(true)
         navigationController?.hidesBarsOnTap = false
     }
    
    func setupUI() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareFlag))
        title = country?.name.uppercased()
        flagImage.image = country?.image
    }
    
    @objc func shareFlag() {
        guard let image = flagImage.image?.jpegData(compressionQuality: 0.8) else {
            return
        }
        guard let text = country?.name else {
            return
        }
        
        let activity = UIActivityViewController(activityItems: [text.uppercased(), image], applicationActivities: [])
        
        activity.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(activity, animated: true, completion: nil)
    }
}
