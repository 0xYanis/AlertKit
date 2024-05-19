//
// AlertMessageViewExtensions.swift
// AlertKit
// https://www.github.com/0xYanis/AlertKit
// See LICENSE for license information.
//

import SwiftUI

/// Adds an alert message to the top of the view.
public extension View {
    /// Adds a custom alert message to the view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the alert should be presented.
    ///   - background: The background style of the alert.
    ///   - content: A content to present.
    func alertMessage<Background, Content>(
        isPresented: SwiftUI.Binding<Bool>,
        background: Background,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Background : ShapeStyle, Content : View {
        ZStack {
            self
            AlertMessageItem(
                isPresented: isPresented,
                background: background,
                content: content
            )
        }
    }
}
