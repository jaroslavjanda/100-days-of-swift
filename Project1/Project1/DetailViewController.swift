//
//  DetailViewController.swift
//  Project1
//
//  Created by Jaroslav Janda on 20/10/2019.
//  Copyright © 2019 Jaroslav Janda. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?
    var countSelect: Int?
    var countTotal: Int?

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Picture \(countSelect!) of \(countTotal!)"
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))

        
        guard let imageToLoad = selectedImage else {
            return
        }
        imageView.image = UIImage(named: imageToLoad)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.hidesBarsOnTap = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.hidesBarsOnTap = false
    }

    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 0.8) else {
            return
        }
           let activity = UIActivityViewController(activityItems: ["Hi this is my image", image], applicationActivities: [])
           activity.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
           present(activity, animated: true)
       }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
