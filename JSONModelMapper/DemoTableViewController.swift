//
//  DemoTableViewController.swift
//  JSONModelMapper
//
//  Created by 杨洋 on 15/12/24.
//  Copyright © 2015年 Sheepy. All rights reserved.
//

import UIKit

struct Constant {
    static let ReuseIdentifier = "Demo Cell"
    static let DemoAPI = "http://api.kanzhihu.com/getposts"
}

class DemoTableViewController: UITableViewController {
    
    var jsonModel: JSONModel? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        
        getDataFromUrl(Constant.DemoAPI, method: .GET, parameter: nil) { data, error in
            if let jsonData = data {
                self.jsonModel = jsonData => JSONModel.self
            }
            
            if let httpError = error {
                print(httpError)
            }
        }
    }
    
    func configCell(cell: UITableViewCell, indexPath: NSIndexPath) -> UITableViewCell {
        
        if let model = jsonModel, post = model.posts[indexPath.section] => PostModel.self {
            cell.textLabel?.text = post.excerpt
        }
        
        return cell
    }
}

// MARK: - Table view data source
extension DemoTableViewController {
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return jsonModel?.count ?? 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constant.ReuseIdentifier, forIndexPath: indexPath)
        
        // Configure the cell...
        return configCell(cell, indexPath: indexPath)
       
    }
}
