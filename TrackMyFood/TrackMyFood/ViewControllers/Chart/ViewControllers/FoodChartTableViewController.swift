//
//  FoodChartViewController.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 9/24/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit
import Dispatch

class FoodChartTableViewController: BaseTableViewController, SegmentsTableViewCellDelegate, FoodChartModelDelegate {
    
    var viewModel: FoodChartTableViewModel = FoodChartTableViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.initView()
        self.viewModel.loadCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.animateProgressBar()
    }
    
    private func animateProgressBar() {
        for cell in self.tableView.visibleCells {
            if (cell.isKind(of: ProgressBarTableViewCell.self)) {
                if let progressCell = cell as? ProgressBarTableViewCell {
                    progressCell.animateProgressBars()
                }
            }
        }
    }
    
    func registerCells() {
        super.registerCells(["ChartTableViewCell", "SegmentsTableViewCell", "QuoteTableViewCell", "ProgressBarTableViewCell"])
    }
    
    private func initView() {
        self.navigationController?.navigationBar.topItem?.title = viewModel.screenTitle
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellModel = self.viewModel.getModelForCell(row: indexPath.row, section: indexPath.section) else {
            return UITableViewCell()
        }
        switch cellModel.cellType {
        case .chart:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "ChartTableViewCell") as? ChartTableViewCell {
                if let model = cellModel.data as? ChartViewModel {
                    cell.initCell(model)
                    cell.selectionStyle = .none
                    return cell
                }
            }
        case .segmentedControl:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier:"SegmentsTableViewCell") as? SegmentsTableViewCell {
                if let model = cellModel.data as? SegmentsCellModel {
                    cell.initCell(model: model, delegate: self)
                    cell.selectionStyle = .none
                    return cell
                }
            }
        case .quote:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell") as? QuoteTableViewCell {
                if let model = cellModel.data as? QuoteCellModel {
                    cell.initCell(model)
                    cell.selectionStyle = .none
                    return cell
                }
            }
        case .progressBar:
            if let cell = self.tableView.dequeueReusableCell(withIdentifier: "ProgressBarTableViewCell") as? ProgressBarTableViewCell {
                if let model = cellModel.data as? ProgressBarCellModel {
                    cell.initCell(model)
                    cell.selectionStyle = .none
                    return cell
                }
            }
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = self.viewModel.getModelForCell(row: indexPath.row, section: indexPath.section)
        let height = model?.height ?? 80
        return height
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.cells.count
    }
    
    // MARK: - Segments Cell Delegate
    
    func segmentedValueChanged(index: Int) {
        self.viewModel.setChartState(index)
        self.viewModel.loadCells()
    }
    
    // MARK: - Food Chart Model Delegate
    
    func notifyCompletion() {
        UIView.transition(with: tableView,
                          duration: 0.35,
                          options: .transitionCrossDissolve,
                          animations: { self.tableView.reloadData() }
        )
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
            self.animateProgressBar()
        })
    }

}
