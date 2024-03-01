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
    ///   - haptic: A feedback that creates haptics to communicate successes, failures, and warnings.
    ///   - content: A closure returning the content of the alert toast.
    func alertToast<Figure, Background, Content>(
        isPresented: SwiftUI.Binding<Bool>,
        shape: Figure,
        background: Background,
        haptic: UINotificationFeedbackGenerator.FeedbackType? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Figure : Shape, Background : ShapeStyle, Content : View {
        ZStack {
            self
            AlertToastItem(
                isPresented: isPresented,
                shape: shape,
                background: background,
                haptic: haptic,
                content: content
            )
        }
    }
    
    
    /// Adds a default alert toast to the view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the alert toast should be presented.
    ///   - haptic: A feedback that creates haptics to communicate successes, failures, and warnings.
    ///   - content: A closure returning the content of the alert toast.
    func alertToast<Content>(
        isPresented: SwiftUI.Binding<Bool>,
        haptic: UINotificationFeedbackGenerator.FeedbackType? = nil,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View where Content : View {
        ZStack {
            self
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color.alertColor,
                haptic: haptic,
                content: content
            )
        }
    }
    
    
    /// Adds an alert toast with a system image and message to the view.
    /// - Parameters:
    ///   - isPresented: A binding to a Boolean value that determines whether the alert toast should be presented.
    ///   - systemImage: The name of the system image (SF Symbols) to display in the alert toast.
    ///   - text: The text for the localized string that describes the of the alert.
    ///   - haptic: A feedback that creates haptics to communicate successes, failures, and warnings.
    func alertToast(
        isPresented: SwiftUI.Binding<Bool>,
        systemImage: String,
        text: LocalizedStringKey,
        haptic: UINotificationFeedbackGenerator.FeedbackType? = nil
    ) -> some View {
        ZStack {
            self
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color.alertColor,
                haptic: haptic
            ) {
                HStack {
                    Image(systemName: systemImage)
                    Text(text)
                }
                .font(.callout)
                .foregroundStyle(.secondary)
            }
        }
    }
    
    
    /// Adds a progress alert toast to the view.
    /// - Parameters:
    ///   - titleKey: The key for the localized string that describes the of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether the alert toast should be presented.
    ///   - haptic: A feedback that creates haptics to communicate successes, failures, and warnings.
    func alertToastProgress(
        _ titleKey: LocalizedStringKey? = nil,
        isPresented: SwiftUI.Binding<Bool>,
        haptic: UINotificationFeedbackGenerator.FeedbackType? = nil
    ) -> some View {
        ZStack {
            self
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color.alertColor,
                haptic: haptic
            ) {
                HStack {
                    ProgressView()
                    if let titleKey { Text(titleKey).padding(.leading, 2) }
                }
                .font(.callout)
                .foregroundStyle(.secondary)
            }
        }
    }
    
    
    /// Adds an alert toast with a custom message to the view.
    /// - Parameters:
    ///   - titleKey: The key for the localized string that describes the of the alert.
    ///   - isPresented: A binding to a Boolean value that determines whether the alert toast should be presented.
    ///   - haptic: A feedback that creates haptics to communicate successes, failures, and warnings.
    func alertToast(
        _ titleKey: LocalizedStringKey,
        isPresented: SwiftUI.Binding<Bool>,
        haptic: UINotificationFeedbackGenerator.FeedbackType? = nil
    ) -> some View {
        ZStack {
            self
            AlertToastItem(
                isPresented: isPresented,
                shape: RoundedRectangle(cornerRadius: 12),
                background: Color.alertColor,
                haptic: haptic
            ) {
                Text(titleKey)
                    .font(.callout)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
