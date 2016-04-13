//
//  ViewController.swift
//  WandaDemo
//
//  Created by Steve Wang on 4/12/16.
//  Copyright © 2016 Steve Wang. All rights reserved.
//

import UIKit
import Charts

class ViewController: UIViewController, HealthServiceDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    //MARK: - IBOutlets
    @IBOutlet var lineChart: LineChartView!
    @IBOutlet var pickerView: UIPickerView!
    
    //MARK: - Properties
    var currPage: HealthPage?
    let service = HealthServices()
    let pickerData = ["Heart Rate", "Weight"]

    //MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChart.noDataText = "Retrieving data"
        
        service.delegate = self
        service.getHeartRate()
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
        
        var keyText: String = ""
        if data.count > 0 {
            keyText = data[0].type.stringByReplacingOccurrencesOfString("_", withString: " ").capitalizedString
        }
        
        let chartDataSet = LineChartDataSet(yVals: entries, label: keyText)
        chartDataSet.drawCircleHoleEnabled = false
        chartDataSet.circleRadius = 6
        
        let chartData = LineChartData(xVals: dates, dataSet: chartDataSet)
        chartData.notifyDataChanged()
        
        lineChart.data = chartData
        lineChart.notifyDataSetChanged()
    }
    
    //MARK: - Buttons
    @IBAction func nextAction(sender: AnyObject) {
        if currPage?.next != nil {
            service.getPage((currPage?.next)!)
        }
    }
    
    @IBAction func previousAction(sender: AnyObject) {
        if currPage?.previous != nil {
            service.getPage((currPage?.previous)!)
        }
    }
    
    //MARK: - Health Service Delegate
    func getHealthPageSuccess(page: HealthPage) {
        self.currPage = page
        self.setChart(page.data)
    }
    
    func getHealthPageFailure(error: NSError) {
        print(error)
    }
    
    //MARK: - Picker View 
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0: service.getHeartRate()
        case 1: service.getBodyWeight()
        default: break
        }
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.textColor = UIColor.blackColor()
        pickerLabel.text = pickerData[row]

        pickerLabel.font = UIFont(name: "Arial-BoldMT", size: 15) // In this use your custom font
        pickerLabel.textAlignment = NSTextAlignment.Center
        return pickerLabel
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
}

