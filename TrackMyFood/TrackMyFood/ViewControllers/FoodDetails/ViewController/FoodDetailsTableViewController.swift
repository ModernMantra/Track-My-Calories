//
//  FoodDetailsViewController.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/26/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class FoodDetailsTableViewController: BaseTableViewController, SaveButtonCellDelegate {
    
    var viewModel: FoodDetailsViewModel = FoodDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
        // Do any additional setup after loading the view.
    }
    
    private func initTableView() {
        self.registerCells()
        self.viewModel.loadCells()
    }
    
    private func registerCells() {
        super.registerCells(["FoodImageTableViewCell", "HashTagsTableViewCell", "SaveFoodTableViewCell", "NutritionTableViewCell"])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View Delegate
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cells.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.getCellHeight(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = self.viewModel.getModelForCell(row: indexPath.row, section: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch cellModel.cellType {
        case .image?:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "FoodImageTableViewCell", for: indexPath) as? FoodImageTableViewCell {
                if let image = cellModel.data as? UIImage {
                    cell.initCell(image: image)
                    cell.selectionStyle = .none
                    return cell
                }
            }
        case .hashTags?:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "HashTagsTableViewCell", for: indexPath) as? HashTagsTableViewCell {
                if let data = cellModel.data as? HashTagsCellModel {
                    cell.selectionStyle = .none
                    cell.initCell(data)
                    return cell
                }
            }
        case .nutrition?:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "NutritionTableViewCell", for: indexPath) as? NutritionTableViewCell {
                if let data = cellModel.data as? NutritionCellModel {
                    cell.initCell(data)
                    cell.selectionStyle = .none
                    return cell
                }
            }
        case .saveButton?:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "SaveFoodTableViewCell", for: indexPath) as? SaveFoodTableViewCell {
                cell.delegate = self
                cell.selectionStyle = .none
                return cell
            }
        default:
            break
        }
        return UITableViewCell()
    }
    
    // MARK: - Save Food Cell Delegate
    
    func buttonTapped() {
        self.viewModel.saveRecognisedFood()
        self.navigationController?.popViewController(animated: true)
    }

}
