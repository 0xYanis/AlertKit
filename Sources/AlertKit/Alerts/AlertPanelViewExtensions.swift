//
// AlertPanelViewExtensions.swift
// AlertKit
// https://www.github.com/0xYanis/AlertKit
// See LICENSE for license information.
//
import SwiftUI

/// Adds an alert panel to the center of the view.
public extension View {
    /// Adds a custom alert panel to the view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the alert panel should be presented.
    ///   - background: The background style of the alert panel.
    ///   - content: A content to present.
    func alertPanel<Content, Background>(
        isPresented: SwiftUI.Binding<Bool>,
        background: Background = Color.systemBackground,
        transition: AnyTransition = .opacity.combined(with: .scale(scale: 0.9)),
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content: View, Background : ShapeStyle {
        ZStack {
            self
            AlertPanelItem(
                isPresented: isPresented,
                background: background,
                transition: transition,
                content: content
            )
        }
    }
}
