//
//  DetailViewController.swift
//  Project7
//
//  Created by Jaroslav Janda on 06/02/2020.
//  Copyright © 2020 Jaroslav Janda. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {
    var webview: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        webview = WKWebView()
        view = webview
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
            <head>
                <meta name="viewport" content="width=device-width, initial-scale=1">
                <style> body {font-size: 150%;} h5 {color:red; text-align:center;} p {color:blue;} </style>
            </head>
            <body>
                <h5>\(detailItem.title)</h5>
                <p>\(detailItem.body)</p>
            </body>
        </html>
"""
        
        webview.loadHTMLString(html, baseURL: nil)
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
