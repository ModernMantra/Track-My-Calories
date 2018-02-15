//
//  DailyInfoViewController.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/9/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit

class DailyInfoTableViewController: BaseTableViewController {
    
    let viewModel: DailyTableViewModel = DailyTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initTableView()
    }
    
    private func initTableView() {
        self.registerCells()
        self.viewModel.loadCells()
    }
    
    private func registerCells() {
        super.registerCells(["ProgressBarsTableViewCell", "DailyCircleTableViewCell"])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadCircleProgressBarCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.viewModel.loadCells()
        self.tableView.reloadData()
    }
    
    private func loadCircleProgressBarCell() {
        for cell in self.tableView.visibleCells {
            if (cell.isKind(of: DailyCircleTableViewCell.self)) {
                if let progressCell = cell as? DailyCircleTableViewCell {
                    progressCell.animateCircleProgressBar()
                }
            }
        }
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cells.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.viewModel.getCellHeight(index: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = self.viewModel.getModelForCell(row: indexPath.row, section: indexPath.section) else {
            return UITableViewCell()
        }
        
        switch cellModel.cellType {
        case .headerDate?:
            return UITableViewCell()
        case .dailyCircle?:
            guard let dailyCircleTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "DailyCircleTableViewCell") as? DailyCircleTableViewCell else {
                return UITableViewCell()
            }
            if let model = cellModel.data as? DailyCircleCellModel {
                dailyCircleTableViewCell.initCell(model: model)
                return dailyCircleTableViewCell
            }
        case .progressBars?:
            guard let progressBarsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "ProgressBarsTableViewCell") as? ProgressBarsTableViewCell else {
                return UITableViewCell()
            }
            if let model = cellModel.data as? ProgressBarsCellModel {
                progressBarsTableViewCell.initCell(cellModel: model)
                return progressBarsTableViewCell
            }
        case .none:
            return UITableViewCell()
        }
        return UITableViewCell()
    }

}
