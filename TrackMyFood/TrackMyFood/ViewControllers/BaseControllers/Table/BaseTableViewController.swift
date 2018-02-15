//
//  BaseTableViewController.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 10/13/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
    }
    
    private func initTableView() {
        self.tableView.allowsSelection = true
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
    }
    
    func registerCells(_ cellNames: [String] = []) {
        if (!cellNames.isEmpty) {
            for cellName in cellNames {
                let cell = UINib(nibName: cellName, bundle: nil)
                self.tableView.register(cell, forCellReuseIdentifier: cellName)
            }
        }
    }

}
