//
//  FeedTableViewController.swift
//  RSSwift
//
//  Created by Arled Kola on 20/09/2014.
//  Copyright (c) 2014 Arled. All rights reserved.
//

import UIKit

class FeedTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate, NSXMLParserDelegate {

    var myFeed : NSArray = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Cell height.
        self.tableView.rowHeight = 70
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        // Set feed url. http://www.formula1.com/rss/news/latest.rss
        var url: NSURL = NSURL.URLWithString("http://www.skysports.com/rss/0,20514,11661,00.xml")
        // XmlParserManager instance/object/variable
        loadRss(url);

    }
    
    func loadRss(data: NSURL) {
        // populate
        var myParser : XmlParserManager = XmlParserManager.alloc().initWithURL(data) as XmlParserManager
        // Put feed in array
        myFeed = myParser.feeds
        
        tableView.reloadData()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let newUrl = segue.destinationViewController as? NewFeedViewController {
            newUrl.onDataAvailable = {[weak self]
                (data) in
                if let weakSelf = self {
                    weakSelf.loadRss(data)
                }
            }
        }
        
        else if segue.identifier == "openPage" {
            
            var indexPath: NSIndexPath = self.tableView.indexPathForSelectedRow()!
            //let selectedFeedURL: String = feeds[indexPath.row].objectForKey("link") as String
            let selectedFTitle: String = myFeed[indexPath.row].objectForKey("title") as String
            let selectedFContent: String = myFeed[indexPath.row].objectForKey("description") as String
            let selectedFURL: String = myFeed[indexPath.row].objectForKey("link") as String
            
            // Instance of our feedpageviewcontrolelr
            let fpvc: FeedPageViewController = segue.destinationViewController as FeedPageViewController

            fpvc.selectedFeedTitle = selectedFTitle
            fpvc.selectedFeedFeedContent = selectedFContent
            fpvc.selectedFeedURL = selectedFURL
        }
    }
    

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myFeed.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        // Feeds dictionary.
        var dict : NSDictionary! = myFeed.objectAtIndex(indexPath.row) as NSDictionary
        
        //set cell properties
        cell.textLabel?.text = myFeed.objectAtIndex(indexPath.row).objectForKey("title") as? String

        cell.detailTextLabel?.text = myFeed.objectAtIndex(indexPath.row).objectForKey("pubDate") as? String

        return cell
    }
}
