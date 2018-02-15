//
//  ChartTableViewCell.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 11/25/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import UIKit
import Charts

class ChartTableViewCell: UITableViewCell {

    @IBOutlet weak var lineChart: LineChartView!
    
    private var model: ChartViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func initCell(_ model: ChartViewModel) {
        self.model = model
        self.updateChart()
    }
    
    private func updateChart() {
        self.lineChart.data = self.model?.dataLine1
        self.lineChart.animate(xAxisDuration: 1.5, yAxisDuration: 1.5)
        self.lineChart.leftAxis.drawLabelsEnabled = false
        self.lineChart.rightAxis.drawLabelsEnabled = false
        self.lineChart.leftAxis.axisLineColor = UIColor.clear
        self.lineChart.rightAxis.axisLineColor = UIColor.clear
        self.lineChart.leftAxis.gridColor = UIColor.clear
        self.lineChart.rightAxis.gridColor = UIColor.clear
        self.lineChart.xAxis.gridColor = UIColor.clear
        self.lineChart.xAxis.drawAxisLineEnabled = false
        self.lineChart.xAxis.labelFont = UIFont(name: "HelveticaNeue-Medium", size: 10)!
        self.lineChart.xAxis.labelTextColor = UIColor.Gray.IronGray
        self.lineChart.xAxis.valueFormatter = self.model?.xAxis.valueFormatter
        self.lineChart.chartDescription?.text = ""
        for set in lineChart.data!.dataSets as! [LineChartDataSet] {
//            set.drawFilledEnabled = !set.drawFilledEnabled
            set.colors = [UIColor.Blue.Chambray]
            set.circleColors = [UIColor.Blue.Chambray]
            set.lineWidth = 3.0
            set.circleRadius = 7.0
            set.circleHoleRadius = 3.0
            set.valueFont = NSUIFont(name: "HelveticaNeue-Medium", size: 9)!
            set.valueColors = [NSUIColor.lightGray]
        }
        self.lineChart.notifyDataSetChanged()
        self.lineChart.data?.notifyDataChanged()
        self.lineChart.setNeedsDisplay()
    }
    
}
