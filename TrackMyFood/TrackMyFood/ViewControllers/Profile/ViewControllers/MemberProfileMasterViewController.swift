//
//  MemberProfileViewController.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/24/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class MemberProfileMasterViewController: UIViewController {
    
    var viewModel: MemmberProfileViewModel = MemmberProfileViewModel()
    
    private lazy var personalInfoViewController: PersonalInfoViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "PersonalInfoViewController") as! PersonalInfoViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()
    
    private lazy var dailyInfoViewController: DailyInfoTableViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "DailyInfoTableViewController") as! DailyInfoTableViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addChildViewController(personalInfoViewController)
        self.setupNavigation()
    }
    
    private func setupNavigation() {
        let image = UIImage(named: "alert")
        let barButtonItem: UIBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(self.barButtonItemPressed))
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = barButtonItem
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.tintColor = UIColor.darkGray.withAlphaComponent(0.8)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func initView() {
        self.navigationController?.navigationBar.topItem?.title = viewModel.screenTitle
    }
    
    // MARK: - Bar button item action
    
    @objc func barButtonItemPressed() {
        if (self.childViewControllers.contains(personalInfoViewController)) {
            let image: UIImage = UIImage(named: "profileRegistration")!
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.image = image
            remove(asChildViewController: personalInfoViewController)
            add(asChildViewController: dailyInfoViewController)
        }
        else {
            let image: UIImage = UIImage(named: "alert")!
            self.navigationController?.navigationBar.topItem?.rightBarButtonItem?.image = image
            remove(asChildViewController: dailyInfoViewController)
            add(asChildViewController: personalInfoViewController)
        }
    }

}
