//
//  FoodListViewController.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/24/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class FoodListTableViewController: BaseTableViewController, FoodListViewModelProtocol, EditFoodProtocol {
    
    var viewModel: FoodListViewModel = FoodListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.viewModel.delegate = self
        self.registerCells()
        self.viewModel.loadCells()
        self.addKeyboardObservers()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.loadCells()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.removeKeyboardObservers()
    }
    
    private func registerCells() {
        super.registerCells(["FoodItemTableViewCell", "FoodItemHeaderTableViewCell"])
    }
    
    private func initView() {
        self.navigationController?.navigationBar.topItem?.title = viewModel.screenTitle
        self.tableView.backgroundColor = UIColor.Gray.WhiteSmoke
    }
    
    private func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        let info: NSDictionary = (notification as NSNotification).userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size
        if let editFoodView = UIApplication.shared.keyWindow?.viewWithTag(456_789),
            let keyboardHeight = keyboardSize?.height, keyboardHeight > 0 {
            UIView.animate(withDuration: Double(0.5), animations: {
                // Calculate overlaping of custom view and keyboard.
                let keyboardY = UIScreen.main.bounds.size.height - keyboardHeight
                let editFoodViewY = editFoodView.frame.origin.y + editFoodView.frame.height
                // Add 10 to result to look better
                editFoodView.frame.origin.y -= (editFoodViewY - keyboardY) + 10
                editFoodView.layoutSubviews()
            })
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {

    }
    
    // MARK: - Table View Delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rows = self.viewModel.sections[self.viewModel.sortedSections[section]]?.count ?? 0
        return rows
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.heightForRow
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.viewModel.getModelForCell(row: indexPath.row, section: indexPath.section) else {
            return UITableViewCell()
        }
        switch cell.cellType {
        case .foodItem?:
            if let reusableCell = self.tableView.dequeueReusableCell(withIdentifier: "FoodItemTableViewCell") as? FoodItemTableViewCell {
                if let cellData = cell.data as? Food {
                    reusableCell.setUpCell(cellData)
                    reusableCell.selectionStyle = .none
                    return reusableCell
                }
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerCell = self.tableView.dequeueReusableCell(withIdentifier: "FoodItemHeaderTableViewCell") as? FoodItemHeaderTableViewCell else {
            return nil
        }
        // Currently there is only one type of header
        let sectionDate = self.viewModel.sortedSections[section]
        let model = HeaderItemCellModel(date: sectionDate)
        headerCell.setUpCell(model)
        return headerCell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewModel.heightForHeader
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.viewModel.getModelForCell(row: indexPath.row, section: indexPath.section) else {
           return
        }
        switch cell.cellType {
        case .foodItem?:
            if let cellData = cell.data as? Food {
                self.showEditFoodView(cellData)
            }
        default:
            break
        }
    }
    
    // MARK: - View Model Delegate
    
    func dataModelPrepared() {
        self.tableView.reloadData()
    }
    
    // MARK: - Edit Food View Delegate
    
    func saveEditingFood(_ model: Food) {
        
    }
    
    func cancelEditingFood() {
        if let blurView = UIApplication.shared.keyWindow?.viewWithTag(123_456) {
            blurView.removeFromSuperview()
            self.tableView.allowsSelection = true
        }
    }
    
    // MARK: - Util
    
    private func showEditFoodView(_ model: Food) {
        let frame = self.viewModel.editFoodViewFrame
        if let editFoodView = EditFoodView.getView(frame, model: model) {
            editFoodView.delegate = self
            editFoodView.tag = 456_789
            editFoodView.center = super.view.center
            editFoodView.layer.cornerRadius = 8
            editFoodView.layer.masksToBounds = true
            self.tableView.allowsSelection = false
            self.tableView.alwaysBounceVertical = false
            let blurView = getBlur()
            UIView.transition(with: self.view, duration: 0.5,
                              options: UIViewAnimationOptions.transitionCrossDissolve,
                              animations: {
                                let window: UIWindow = UIApplication.shared.windows.first!
                                window.addSubview(editFoodView)
                                self.view.insertSubview(blurView, belowSubview: editFoodView)
            },
                              completion: nil)
        }
    }
    
    private func getBlur() -> UIView {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        blurEffectView.tag = 123_456
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        return blurEffectView
    }

}
