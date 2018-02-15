//
//  BaseNavigationViewController.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/24/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        // Do any additional setup after loading the view.
    }
    
    private func initView() {
        self.navigationBar.barTintColor = UIColor.Gray.WhiteSmoke
        self.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.Blue.BlueWhale, NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 20)]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
