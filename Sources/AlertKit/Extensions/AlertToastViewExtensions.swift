//
// AlertToastViewExtensions.swift
// AlertKit
// https://www.github.com/0xYanis/AlertKit
// See LICENSE for license information.
//

import SwiftUI

// Adds an alert toast to the view.
public extension View {
    /// Adds a custom alert toast to the view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the alert toast should be presented.
    ///   - shape: The shape of the alert toast.
    ///   - background: The background style of the alert toast.
    ///   - content: A closure returning the content of the alert toast.
    func alertToast<Figure, Background, Content>(
        isPresented: SwiftUI.Binding<Bool>,
        shape: Figure,
        background: Background,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Figure : Shape, Background : ShapeStyle, Content : View {
        ZStack {
            self
            AlertToastItem(
                isPresented: isPresented,
                shape: shape,
                background: background,
                content: content
            )
        }
    }
    
    
    /// Adds a default alert toast to the view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the alert toast should be presented.
    ///   - content: A closure returning the content of the alert toast.
    func alertToast<Content>(
        isPresented: SwiftUI.Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        ZStack {
            self
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color.alertColor,
                content: content
            )
        }
    }
    
    
    /// Adds an alert toast with a system image and message to the view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the alert toast should be presented.
    ///   - systemImage: The name of the system image (SF Symbols) to display in the alert toast.
    ///   - message: The message to display in the alert toast.
    func alertToast(
        isPresented: SwiftUI.Binding<Bool>,
        systemImage: String,
        message: String
    ) -> some View {
        ZStack {
            self
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color.alertColor) {
                    HStack {
                        Image(systemName: systemImage)
                        Text(message)
                    }
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
        }
    }
    
    
    /// Adds a progress alert toast to the view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the alert toast should be presented.
    ///   - message: An optional message to display with the progress indicator.
    func alertToastProgress(
        isPresented: SwiftUI.Binding<Bool>,
        message: String? = nil
    ) -> some View {
        ZStack {
            self
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color.alertColor) {
                    HStack {
                        ProgressView()
                        if let text = message {
                            Text(text).padding(.leading, 2)
                        }
                    }
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
        }
    }
    
    
    /// Adds an alert toast with a custom message to the view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the alert toast should be presented.
    ///   - message: The message to display in the alert toast.
    func alertToast(
        isPresented: SwiftUI.Binding<Bool>,
        message: String
    ) -> some View {
        ZStack {
            self
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color.alertColor) {
                    Text(message)
                    .font(.callout)
                    .foregroundStyle(.secondary)
                }
        }
    }
}
