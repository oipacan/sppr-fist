//
//  ViewController.swift
//  MobileClient
//
//  Created by Alexander on 06/03/16.
//  Copyright © 2016 Alexander Tikhonov. All rights reserved.
//

import UIKit
import Charts

class FPChartViewController: UIViewController {

    @IBOutlet weak var chartView: LineChartView!
    let options = [
        ["key": "toggleValues", "label": "Toggle Values"],
        ["key": "toggleFilled", "label": "Toggle Filled"],
        ["key": "toggleCircles", "label": "Toggle Circles"],
        ["key": "toggleCubic", "label": "Toggle Cubic"],
        ["key": "toggleStepped", "label": "Toggle Stepped"],
        ["key": "toggleHighlight", "label": "Toggle Highlight"],
        ["key": "animateX", "label": "Animate X"],
        ["key": "animateY", "label": "Animate Y"],
        ["key": "animateXY", "label": "Animate XY"],
        ["key": "saveToGallery", "label": "Save to Camera Roll"],
        ["key": "togglePinchZoom", "label": "Toggle PinchZoom"],
        ["key": "toggleAutoScaleMinMax", "label": "Toggle auto scale min/max"],
        ["key": "toggleData", "label": "Toggle Data"]
    ]
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewController()
    }

    // MARK: Method
    func prepareViewController() {
        chartView.delegate = self
        chartView.descriptionText = "Researh work"
        chartView.noDataTextDescription = "You need to provide data for the chart"
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = true
        chartView.drawGridBackgroundEnabled = false
        
        let llXAxis = ChartLimitLine(limit: 10.0, label: "Index 10")
        llXAxis.lineWidth = 4.0
        llXAxis.lineDashLengths = [10.0, 10.0, 0.0]
        llXAxis.labelPosition = .RightBottom
        llXAxis.valueFont = UIFont.systemFontOfSize(10)
        // chartView.xAxis.addLimitLine(llXAxis)

        let ll1 = ChartLimitLine(limit: 130, label: "Upper limit")
        ll1.lineWidth = 4.0
        ll1.lineDashLengths = [5.0, 5.0]
        ll1.labelPosition = .RightBottom
        ll1.valueFont = UIFont.systemFontOfSize(10)
        
        let ll2 = ChartLimitLine(limit: -15, label: "Lower limit")
        ll2.lineWidth = 4.0
        ll2.lineDashLengths = [5.0, 5.0]
        ll2.labelPosition = .RightBottom
        ll2.valueFont = UIFont.systemFontOfSize(10)
        
        let leftAxis = chartView.leftAxis
        leftAxis.removeAllLimitLines()
        leftAxis.addLimitLine(ll1)
        leftAxis.addLimitLine(ll2)
        leftAxis.customAxisMax = 220.0
        leftAxis.customAxisMin = -50.0
        leftAxis.gridLineDashLengths = [5.0, 5.0]
        leftAxis.drawZeroLineEnabled = false
        leftAxis.drawLimitLinesBehindDataEnabled = true
        
        chartView.rightAxis.enabled = false
        
        chartView.viewPortHandler.setMaximumScaleX(2.0)
        chartView.viewPortHandler.setMaximumScaleY(2.0)
        
        let marker = BalloonMarker(color: ChartColorTemplates.colorFromString("#E76C17"), font: UIFont.systemFontOfSize(12.0), insets: UIEdgeInsets(top: 8.0, left: 8.0, bottom: 20.0, right: 8.0))
        marker.minimumSize = CGSize(width: 60.0, height: 20.0)
        chartView.marker = marker
        
        chartView.legend.form = .Line
        
        updateChartData(10, range: 100)
        
        chartView.animate(xAxisDuration: 2.5, easingOption: .EaseInOutQuart)
    }

    func updateChartData(count: Int, range: UInt32) {
        let xVals = Array(0...count).map{String($0)}
        let yVals = Array(0...count).map{ index -> ChartDataEntry in
            let value: Double = Double(arc4random_uniform(range))
            return ChartDataEntry(value: value, xIndex: index)
        }
        
        let set1 = LineChartDataSet(yVals: yVals, label: "Experimental data")
        
        set1.lineDashLengths = [5.0, 2.5]
        set1.highlightLineDashLengths = [5.0, 2.5]
        set1.setColor(.blackColor())
        set1.setCircleColor(.whiteColor())
        set1.lineWidth = 1.0
        set1.circleRadius = 3.0
        set1.drawCircleHoleEnabled = false
        set1.valueFont = UIFont.systemFontOfSize(9.0)
        
        let gradientColors = [
            ChartColorTemplates.colorFromString("#ACCDF800").CGColor,
            ChartColorTemplates.colorFromString("#5472D100").CGColor
        ]
        let gradient = CGGradientCreateWithColors(nil, gradientColors, nil)
        set1.fillAlpha = 1.0
        set1.fill = ChartFill.fillWithLinearGradient(gradient!, angle: 90.0)
        set1.drawFilledEnabled = true
        
        let lineChartData = LineChartData(xVals: xVals, dataSets: [set1])
        chartView.data = lineChartData
    }
}

extension FPChartViewController: ChartViewDelegate {
    func chartValueSelected(chartView: ChartViewBase, entry: ChartDataEntry, dataSetIndex: Int, highlight: ChartHighlight) {
        print("chartValueSelected")
    }
    
    func chartValueNothingSelected(chartView: ChartViewBase) {
        print("chartValueNothingSelected")
    }
}

