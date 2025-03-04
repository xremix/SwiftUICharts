//
//  LegendView.swift
//  LineChart
//
//  Created by Will Dale on 09/01/2021.
//

import SwiftUI

/**
 Sub view to setup and display the legends.
 */
internal struct LegendView<T>: View where T: CTChartData {
    
    @ObservedObject var chartData : T
    private let columns     : [GridItem]
    private let width       : CGFloat
    private let font        : Font
    private let textColor   : Color
            
    internal init(chartData: T,
                  columns  : [GridItem],
                  width    : CGFloat,
                  font     : Font,
                  textColor: Color
    ) {
        self.chartData = chartData
        self.columns   = columns
        self.width     = width
        self.font      = font
        self.textColor = textColor
    }
    
    internal var body: some View {
        
        LazyVGrid(columns: columns, alignment: .leading) {
            ForEach(chartData.legends, id: \.id) { legend in
                
                legend.getLegend(width: width, font: font, textColor: textColor)
                    .if(scaleLegendBar(legend: legend)) { $0.scaleEffect(1.2, anchor: .leading) }
                    .if(scaleLegendPie(legend: legend)) {$0.scaleEffect(1.2, anchor: .leading) }
                    .accessibilityLabel(Text(legend.accessibilityLegendLabel()))
                    .accessibilityValue(Text(legend.legend))
            }
        }
    }
    
    /// Detects whether to run the scale effect on the legend.
    private func scaleLegendBar(legend: LegendData) -> Bool {
        
        if chartData is BarChartData {
            if let datapointID = chartData.infoView.touchOverlayInfo.first?.id as? UUID {
                return chartData.infoView.isTouchCurrent && legend.id == datapointID
            } else {
                return false
            }
        } else if chartData is GroupedBarChartData || chartData is StackedBarChartData {
            if let datapoint = chartData.infoView.touchOverlayInfo.first as? MultiBarChartDataPoint {
                return chartData.infoView.isTouchCurrent && legend.colour == datapoint.group.colour
            } else {
                return false
            }
        } else {
            return false
        }
    }
    /// Detects whether to run the scale effect on the legend.
    private func scaleLegendPie(legend: LegendData) -> Bool {
        
        if chartData is PieChartData || chartData is DoughnutChartData {
            if let datapointID = chartData.infoView.touchOverlayInfo.first?.id as? UUID {
                return chartData.infoView.isTouchCurrent && legend.id == datapointID
            } else {
                return false
            }
        } else {
           return false
       }
    }
}
