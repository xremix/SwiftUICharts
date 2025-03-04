//
//  LineChartSubViews.swift
//  
//
//  Created by Will Dale on 26/01/2021.
//

import SwiftUI

struct AccessibilityRectangle: Shape {
    
    let dataPointCount : Int
    let dataPointNo    : Int
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let x = rect.width / CGFloat(dataPointCount-1)
        let pointX : CGFloat = (CGFloat(dataPointNo) * x) - x / CGFloat(2)
        
        let point  : CGRect  = CGRect(x     : pointX,
                                      y     : 0,
                                      width :  x,
                                      height:  rect.height)
        
        path.addRoundedRect(in: point, cornerSize: CGSize(width: 10, height: 10))
        
        return path
    }
}

// MARK: - Single colour
/**
 Sub view gets the line drawn, sets the colour and sets up the animations.
 
 Single colour
 */
internal struct LineChartColourSubView<CD, DS>: View where CD: CTLineChartDataProtocol,
                                                           DS: CTLineChartDataSet,
                                                           DS.DataPoint: CTStandardDataPointProtocol {
    
    private let chartData   : CD
    private let dataSet     : DS
    private let minValue    : Double
    private let range       : Double
    private let colour      : Color
    private let isFilled    : Bool
           
    internal init(chartData : CD,
                  dataSet   : DS,
                  minValue  : Double,
                  range     : Double,
                  colour    : Color,
                  isFilled  : Bool
    ) {
        self.chartData  = chartData
        self.dataSet    = dataSet
        self.minValue   = minValue
        self.range      = range
        self.colour     = colour
        self.isFilled   = isFilled
    }
    
    @State private var startAnimation : Bool = false
    
    internal var body: some View {
        
        LineShape(dataPoints: dataSet.dataPoints,
                  lineType  : dataSet.style.lineType,
                  isFilled  : isFilled,
                  minValue  : minValue,
                  range     : range,
                  ignoreZero: dataSet.style.ignoreZero)
            .ifElse(isFilled, if: {
                $0.scale(y: startAnimation ? 1 : 0, anchor: .bottom)
                    .fill(colour)
            }, else: {
                $0.trim(to: startAnimation ? 1 : 0)
                    .stroke(colour, style: dataSet.style.strokeStyle.strokeToStrokeStyle())
            })
            .background(Color(.gray).opacity(0.000000001))
            .if(chartData.viewData.hasXAxisLabels) { $0.xAxisBorder(chartData: chartData) }
            .if(chartData.viewData.hasYAxisLabels) { $0.yAxisBorder(chartData: chartData) }
            .animateOnAppear(using: chartData.chartStyle.globalAnimation) {
                self.startAnimation = true
            }
            .animateOnDisappear(using: chartData.chartStyle.globalAnimation) {
                self.startAnimation = false
            }
    }
}


// MARK: - Gradient colour
/**
 Sub view gets the line drawn, sets the colour and sets up the animations.
 
 Gradient colour
 */
internal struct LineChartColoursSubView<CD, DS>: View where CD: CTLineChartDataProtocol,
                                                            DS: CTLineChartDataSet,
                                                            DS.DataPoint: CTStandardDataPointProtocol {
    
    private let chartData   : CD
    private let dataSet     : DS
    
    private let minValue    : Double
    private let range       : Double
    private let colours     : [Color]
    private let startPoint  : UnitPoint
    private let endPoint    : UnitPoint
    
    private let isFilled    : Bool
    
    internal init(chartData : CD,
                  dataSet   : DS,
                  minValue  : Double,
                  range     : Double,
                  colours   : [Color],
                  startPoint: UnitPoint,
                  endPoint  : UnitPoint,
                  isFilled  : Bool
    ) {
        self.chartData  = chartData
        self.dataSet    = dataSet
        self.minValue   = minValue
        self.range      = range
        self.colours    = colours
        self.startPoint = startPoint
        self.endPoint   = endPoint
        self.isFilled   = isFilled
    }
    
    @State private var startAnimation : Bool = false
    
    internal var body: some View {
        
        ZStack {
            
            chartData.getAccessibility()
            
            LineShape(dataPoints: dataSet.dataPoints,
                      lineType  : dataSet.style.lineType,
                      isFilled  : isFilled,
                      minValue  : minValue,
                      range     : range,
                      ignoreZero: dataSet.style.ignoreZero)
                .ifElse(isFilled, if: {
                    $0
                        .scale(y: startAnimation ? 1 : 0, anchor: .bottom)
                        .fill(LinearGradient(gradient: Gradient(colors: colours),
                                             startPoint: startPoint,
                                             endPoint: endPoint))
                }, else: {
                    $0
                        .trim(to: startAnimation ? 1 : 0)
                        .stroke(LinearGradient(gradient: Gradient(colors: colours),
                                               startPoint: startPoint,
                                               endPoint: endPoint),
                                style: dataSet.style.strokeStyle.strokeToStrokeStyle())
                })
                
                
                .background(Color(.gray).opacity(0.000000001))
                .if(chartData.viewData.hasXAxisLabels) { $0.xAxisBorder(chartData: chartData) }
                .if(chartData.viewData.hasYAxisLabels) { $0.yAxisBorder(chartData: chartData) }
                .animateOnAppear(using: chartData.chartStyle.globalAnimation) {
                    self.startAnimation = true
                }
                .animateOnDisappear(using: chartData.chartStyle.globalAnimation) {
                    self.startAnimation = false
                }
        }
    }
}

// MARK: - Gradient with stops
/**
 Sub view gets the line drawn, sets the colour and sets up the animations.
 
 Gradient with stops
 */
internal struct LineChartStopsSubView<CD, DS>: View where CD: CTLineChartDataProtocol,
                                                          DS: CTLineChartDataSet,
                                                          DS.DataPoint: CTStandardDataPointProtocol {

    private let chartData   : CD
    private let dataSet     : DS

    private let minValue    : Double
    private let range       : Double
    private let stops       : [Gradient.Stop]
    private let startPoint  : UnitPoint
    private let endPoint    : UnitPoint

    private let isFilled    : Bool
    
    internal init(chartData : CD,
                  dataSet   : DS,
                  minValue  : Double,
                  range     : Double,
                  stops     : [Gradient.Stop],
                  startPoint: UnitPoint,
                  endPoint  : UnitPoint,
                  isFilled  : Bool
    ) {
        self.chartData  = chartData
        self.dataSet    = dataSet
        self.minValue   = minValue
        self.range      = range
        self.stops      = stops
        self.startPoint = startPoint
        self.endPoint   = endPoint
        self.isFilled   = isFilled
    }
    
    @State private var startAnimation : Bool = false
    
    internal var body: some View {
        
        ZStack {
            
            chartData.getAccessibility()
            
            LineShape(dataPoints: dataSet.dataPoints,
                      lineType  : dataSet.style.lineType,
                      isFilled  : isFilled,
                      minValue  : minValue,
                      range     : range,
                      ignoreZero: dataSet.style.ignoreZero)
                
                .ifElse(isFilled, if: {
                    $0
                        .scale(y: startAnimation ? 1 : 0, anchor: .bottom)
                        .fill(LinearGradient(gradient: Gradient(stops: stops),
                                             startPoint: startPoint,
                                             endPoint: endPoint))
                }, else: {
                    $0
                        .trim(to: startAnimation ? 1 : 0)
                        .stroke(LinearGradient(gradient: Gradient(stops: stops),
                                               startPoint: startPoint,
                                               endPoint: endPoint),
                                style: dataSet.style.strokeStyle.strokeToStrokeStyle())
                })
                
                .background(Color(.gray).opacity(0.000000001))
                .if(chartData.viewData.hasXAxisLabels) { $0.xAxisBorder(chartData: chartData) }
                .if(chartData.viewData.hasYAxisLabels) { $0.yAxisBorder(chartData: chartData) }
                .animateOnAppear(using: chartData.chartStyle.globalAnimation) {
                    self.startAnimation = true
                }
                .animateOnDisappear(using: chartData.chartStyle.globalAnimation) {
                    self.startAnimation = false
                }
        }
    }
}

