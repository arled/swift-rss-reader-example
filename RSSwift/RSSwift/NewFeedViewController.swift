//
//  NewFeedViewController.swift
//  RSSwift
//
//  Created by Arled Kola on 27/10/2014.
//  Copyright (c) 2014 Arled. All rights reserved.
//

import UIKit

class NewFeedViewController: UIViewController {

    @IBOutlet var textFieldNewFeedUrl: UITextField!
    
    // Reusbale member
    var onDataAvailable : ((_ data: URL) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneTapped(_ sender: AnyObject) {
        
        // Send new Url
        if (textFieldNewFeedUrl.text != "") {
            self.onDataAvailable?(URL(string: textFieldNewFeedUrl.text!)!)
//            self.navigationController?.popToRootViewController(animated: true)
        } else {
//            self.navigationController?.popToRootViewController(animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
