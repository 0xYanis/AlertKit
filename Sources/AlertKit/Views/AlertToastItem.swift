//
// AlertToastItem.swift
// AlertKit
// https://www.github.com/0xYanis/AlertKit
// See LICENSE for license information.
//

import SwiftUI

struct AlertToastItem<Content, Figure, Background>: View where Content : View, Figure : Shape, Background : ShapeStyle {
    @Binding private var isPresented: Bool
    @State private var timer: Timer?
    @State private var offset = CGSize()
    
    private var timeInterval: TimeInterval
    private var shape: Figure
    private var background: Background
    private var haptic: UINotificationFeedbackGenerator.FeedbackType?
    private var content: () -> Content
    
    private let generator = UINotificationFeedbackGenerator()
    
    init(
        isPresented: SwiftUI.Binding<Bool>,
        timeInterval: TimeInterval = 3,
        shape: Figure,
        background: Background,
        haptic: UINotificationFeedbackGenerator.FeedbackType?,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.timeInterval = timeInterval
        self.shape = shape
        self.background = background
        self.haptic = haptic
        self.content = content
    }
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                if isPresented {
                    contentView
                }
            }
            .gesture(DragGesture()
                .onChanged(onChanged)
                .onEnded(onEnded)
            )
            .onChange(of: isPresented) { newValue in
                if newValue { resetTimer()
                } else { timer?.invalidate() }
            }
        }
        .animation(.smooth(duration: 0.2), value: isPresented)
    }
    
    private var contentView: some View {
        content()
            .modifier(BaseModifier(
                background: background,
                shape: shape,
                transition: .move(edge: .top)
                    .combined(with: .scale(scale: 0.7))
                    .combined(with: .opacity)))
            .offset(y: offset.height <= 40 ? offset.height : 0)
            .onAppear {
                if let haptic {
                    generator.notificationOccurred(haptic)
                }
            }
    }
    
    private func onChanged(_ gesture: DragGesture.Value) {
        if offset.height <= 40 {
            withAnimation(.smooth) {
                offset = gesture.translation
            }
        }
        timer?.invalidate()
    }
    
    private func onEnded(_ gesture: DragGesture.Value) {
        if offset.height > 0 {
            withAnimation(.smooth) {
                offset = .zero
            }
        }
        
        if offset.height < -10 {
            hideAlert()
        }
        
        resetTimer()
    }
    
    private func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: false) { _ in
            hideAlert()
        }
    }
    
    private func hideAlert() {
        withAnimation(.smooth) {
            isPresented = false
            timer?.invalidate()
            offset = .zero
        }
    }
}
