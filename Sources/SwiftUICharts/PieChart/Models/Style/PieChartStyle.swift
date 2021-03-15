//
//  PieChartStyle.swift
//  
//
//  Created by Will Dale on 25/01/2021.
//

import SwiftUI

/**
 Model for controlling the overall aesthetic of the chart.
 */
public struct PieChartStyle: CTPieChartStyle {
        
    public var infoBoxPlacement         : InfoBoxPlacement
    public var infoBoxValueColour       : Color
    public var infoBoxDescriptionColour : Color
    public var infoBoxBackgroundColour  : Color
    public var infoBoxBorderColour      : Color
    public var infoBoxBorderStyle       : StrokeStyle
    
    public var globalAnimation          : Animation
    
    /// Model for controlling the overall aesthetic of the chart.
    /// - Parameters:
    ///   - infoBoxPlacement: Placement of the information box that appears on touch input.
    ///   - infoBoxValueColour: Colour of the value part of the touch info.
    ///   - infoBoxDescriptionColour: Colour of the description part of the touch info.
    ///   - infoBoxBackgroundColour: Background colour of touch info.
    ///   - infoBoxBorderColour: Border colour of the touch info.
    ///   - infoBoxBorderStyle: Border style of the touch info.
    ///   - globalAnimation: Global control of animations.
    public init(infoBoxPlacement        : InfoBoxPlacement  = .floating,
                infoBoxValueColour      : Color             = Color.primary,
                infoBoxDescriptionColour: Color             = Color.primary,
                infoBoxBackgroundColour : Color             = Color.systemsBackground,
                infoBoxBorderColour     : Color             = Color.clear,
                infoBoxBorderStyle      : StrokeStyle       = StrokeStyle(lineWidth: 0),
                globalAnimation         : Animation         = Animation.linear(duration: 1)
    ) {
        self.infoBoxPlacement         = infoBoxPlacement
        self.infoBoxValueColour       = infoBoxValueColour
        self.infoBoxDescriptionColour = infoBoxDescriptionColour
        self.infoBoxBackgroundColour  = infoBoxBackgroundColour
        self.infoBoxBorderColour      = infoBoxBorderColour
        self.infoBoxBorderStyle       = infoBoxBorderStyle
        self.globalAnimation          = globalAnimation
    }
}


