//
//  FeedTableViewController.swift
//  RSSwift
//
//  Created by Arled Kola on 20/09/2014.
//  Copyright (c) 2014 Arled. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, XMLParserDelegate {

    var myFeed : NSArray = []
    var url: URL!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Cell height.
        self.tableView.rowHeight = 70
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Set feed url. http://www.formula1.com/rss/news/latest.rss
        url = URL(string: "http://www.skysports.com/rss/0,20514,11661,00.xml")!
        // Call custom function.
        loadRss(url);

    }
    
    func loadRss(_ data: URL) {
        // XmlParserManager instance/object/variable
        let myParser : XmlParserManager = XmlParserManager().initWithURL(data) as! XmlParserManager
        // Put feed in array
        myFeed = myParser.feeds
        
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let newUrl = segue.destination as? NewFeedViewController {
            newUrl.onDataAvailable = {[weak self]
                (data) in
                if let weakSelf = self {
                    weakSelf.loadRss(data as URL)
                }
            }
        }
        
        else if segue.identifier == "openPage" {
            
            let indexPath: IndexPath = self.tableView.indexPathForSelectedRow!
            //let selectedFeedURL: String = feeds[indexPath.row].objectForKey("link") as String
            let selectedFTitle: String = (myFeed[indexPath.row] as AnyObject).object(forKey: "title") as! String
            let selectedFContent: String = (myFeed[indexPath.row] as AnyObject).object(forKey: "description") as! String
            let selectedFURL: String = (myFeed[indexPath.row] as AnyObject).object(forKey: "link") as! String
            
            // Instance of our feedpageviewcontrolelr
            let fpvc: FeedPageViewController = segue.destination as! FeedPageViewController

            fpvc.selectedFeedTitle = selectedFTitle
            fpvc.selectedFeedFeedContent = selectedFContent
            fpvc.selectedFeedURL = selectedFURL
        }
    }
    

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeed.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) 
        
        // Feeds dictionary.
//        var dict : NSDictionary! = myFeed.objectAtIndex(indexPath.row) as! NSDictionary
        
        // Set cell properties.
        cell.textLabel?.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "title") as? String

        cell.detailTextLabel?.text = (myFeed.object(at: indexPath.row) as AnyObject).object(forKey: "pubDate") as? String

        return cell
    }
}
