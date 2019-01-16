//
//  ViewController.swift
//  TableView PullToRefresh
//
//  Created by Prashant G on 1/16/19.
//  Copyright © 2019 Prashant G. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    
    
//    lazy var refresher: UIRefreshControl = {
//        let refreshControl = UIRefreshControl()
//        refreshControl.tintColor = .white
//        refreshControl.addTarget(self, action: #selector(requestData), for: .valueChanged)
//        return refreshControl
//    }()
    
    var refresher = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.navigationController?.navigationBar.prefersLargeTitles = true
//        tableView.tableFooterView = UIView()
        
        refresher.tintColor = .white
        refresher.addTarget(self, action: #selector(requestData), for: .valueChanged)
        
        if #available(iOS 10.0, *){
            tableView.refreshControl = refresher
        }
        else{
            tableView.addSubview(refresher)
        }
    }
    
    @objc
    func requestData(refreshControl: UIRefreshControl) {
        print("refreshing")
        let deadline = DispatchTime.now() + .milliseconds(1000)
        DispatchQueue.main.asyncAfter(deadline: deadline) {
            refreshControl.endRefreshing()
            print("fetched data")
        }
    }

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
        cell.textLabel?.text = String(indexPath.row)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

