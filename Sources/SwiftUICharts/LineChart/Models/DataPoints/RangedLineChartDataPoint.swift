//
//  RangedLineChartDataPoint.swift
//  
//
//  Created by Will Dale on 02/03/2021.
//

import SwiftUI

/**
 Data for a single ranged data point.
 
 # Example
 ```
 RangedLineChartDataPoint(value: 10,
                          upperValue: 20,
                          lowerValue: 0,
                          xAxisLabel: "M",
                          description: "Monday")
 ```
 */
public struct RangedLineChartDataPoint: CTRangedLineDataPoint {
    
    public let id          : UUID = UUID()
    public var value       : Double
    public var upperValue  : Double
    public var lowerValue  : Double
    public var xAxisLabel  : String?
    public var description : String?
    public var date        : Date?
    
    public var legendTag : String = ""
        
    /// Data model for a single data point with colour for use with a ranged line chart.
    /// - Parameters:
    ///   - value: Value of the data point.
    ///   - upperValue: Value of the upper range of the data point.
    ///   - lowerValue: Value of the lower range of the data point.
    ///   - xAxisLabel: Label that can be shown on the X axis.
    ///   - description: A longer label that can be shown on touch input.
    ///   - date: Date of the data point if any data based calculations are required.
    public init(value       : Double,
                upperValue  : Double,
                lowerValue  : Double,
                xAxisLabel  : String?   = nil,
                description : String?   = nil,
                date        : Date?     = nil
    ) {
        self.value       = value
        self.upperValue  = upperValue
        self.lowerValue  = lowerValue
        self.xAxisLabel  = xAxisLabel
        self.description = description
        self.date        = date
    }
}
