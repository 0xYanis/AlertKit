//
// AlertBarViewExtensions.swift
// AlertKit
// https://www.github.com/0xYanis/AlertKit
// See LICENSE for license information.
//

import SwiftUI

/// Adds an alert bar to the bottom of the view.
public extension View {
    /// Adds a custom alert bar to the view, positioned at the bottom.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean that determines whether the alert bar should be presented.
    ///   - timeInterval: The time interval for which the alert bar should be displayed.
    ///   - shape: The shape of the alert bar.
    ///   - background: The background style of the alert bar.
    ///   - content: A closure returning the content of alert bar.
    func alertBar<Figure, Background, Content>(
        isPresented: SwiftUI.Binding<Bool>,
        timeInterval: TimeInterval = 3,
        shape: Figure,
        background: Background,
        haptic: UINotificationFeedbackGenerator.FeedbackType? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Figure : Shape, Background : ShapeStyle, Content : View {
        ZStack {
            self
            AlertBarItem(
                isPresented: isPresented,
                timeInterval: timeInterval,
                shape: shape,
                background: background,
                haptic: haptic,
                content: content
            )
        }
    }
    
    
    /// Adds alert bar to the view, positioned at the bottom.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean that determines whether the alert bar should be presented.
    ///   - timeInterval: The time interval for which the alert bar should be displayed.
    ///   - content: A closure returning the content of alert bar.
    func alertBar<Content>(
        isPresented: SwiftUI.Binding<Bool>,
        timeInterval: TimeInterval = 3,
        haptic: UINotificationFeedbackGenerator.FeedbackType? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        ZStack {
            self
            AlertBarItem(
                isPresented: isPresented,
                timeInterval: timeInterval,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color.alertColor,
                haptic: haptic,
                content: content
            )
        }
    }
}
