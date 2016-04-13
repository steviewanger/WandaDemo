//
//  ViewController.swift
//  WandaDemo
//
//  Created by Steve Wang on 4/12/16.
//  Copyright © 2016 Steve Wang. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet var lineChart: LineChartView!

    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.noDataText = "Retrieving data"
        
        let success = {(page: HealthPage) in
            self.setChart(page.data)
        }
        
        let failure = {(error: NSError) in
            print(error)
        }
        
        HealthServices.getHeartRate(success, errorBlock: failure)
    }

    //MARK: - Charts
    func setChart(data: [HealthData]) {
        lineChart.noDataText = "No data retrieved"
        
        var entries = Array<ChartDataEntry>()
        var dates = Array<String>()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "MM/dd/YY"
        
        for i in 0..<data.count {
            entries.append(ChartDataEntry(value: data[i].value, xIndex: i))
            dates.append("\(formatter.stringFromDate(data[i].time))")
        }
        
        print(data.count)
        let chartDataSet = LineChartDataSet(yVals: entries, label: "Heart Rate")
        chartDataSet.drawCircleHoleEnabled = false
        chartDataSet.circleRadius = 6
        
        let chartData = LineChartData(xVals: dates, dataSet: chartDataSet)
        
        lineChart.data = chartData
        
        lineChart.notifyDataSetChanged()
    }
}

