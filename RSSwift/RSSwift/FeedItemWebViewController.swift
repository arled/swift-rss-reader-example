//
//  FeedItemWebViewController.swift
//  Rsswift
//
//  Created by Arled Kola on 12/03/2019.
//  Copyright © 2019 ArledKola. All rights reserved.
//

import UIKit
import WebKit

class FeedItemWebViewController: UIViewController {
    @IBOutlet var webView: WKWebView!
    var selectedFeedURL: String?
    
    private var loadingObservation: NSKeyValueObservation?

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.color = .orange
        spinner.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return spinner
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingObservation = webView.observe(\.isLoading, options: [.new, .old]) { [weak self] (_, change) in
            guard let strongSelf = self else { return }

            if change.newValue! && !change.oldValue! {
                strongSelf.view.addSubview(strongSelf.loadingIndicator)
                strongSelf.loadingIndicator.startAnimating()
                NSLayoutConstraint.activate([strongSelf.loadingIndicator.centerXAnchor.constraint(equalTo: strongSelf.view.centerXAnchor),
                                             strongSelf.loadingIndicator.centerYAnchor.constraint(equalTo: strongSelf.view.centerYAnchor)])
                strongSelf.view.bringSubviewToFront(strongSelf.loadingIndicator)
            }
            
            else if !change.newValue! && change.oldValue! {
                strongSelf.loadingIndicator.stopAnimating()
                strongSelf.loadingIndicator.removeFromSuperview()
            }
        }
        
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: " ", with:"")
        selectedFeedURL =  selectedFeedURL?.replacingOccurrences(of: "\n", with:"")
        webView.backgroundColor = .white
        webView.load(URLRequest(url: URL(string: selectedFeedURL! as String)!))
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear( animated )
    }
}
