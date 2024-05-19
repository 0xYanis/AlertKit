//
// AlertBarItem.swift
// AlertKit
// https://www.github.com/0xYanis/AlertKit
// See LICENSE for license information.
//

import SwiftUI

struct AlertBarItem<Content, Figure, Background>: View where Content : View, Figure : Shape, Background : ShapeStyle {
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
        GeometryReader { proxy in
            ZStack {
                if isPresented {
                    contentView(proxy)
                }
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .bottom
            )
            .gesture(DragGesture()
                .onChanged(onChanged)
                .onEnded(onEnded)
            )
        }
        .animation(.smooth, value: isPresented)
        .onChange(of: isPresented) { newValue in
            if newValue { resetTimer()
            } else { timer?.invalidate() }
        }
    }
    
    @ViewBuilder
    private func contentView(_ proxy: GeometryProxy) -> some View {
        content()
            .modifier(BaseModifier(
                background: background,
                shape: shape,
                transition: .slide
                    .combined(with: .scale(scale: 1.0))
                    .combined(with: .opacity))
            )
            .offset(y: -proxy.safeAreaInsets.bottom)
            .offset(x: offset.width)
            .padding(.horizontal)
            .onAppear {
                if let haptic {
                    generator.notificationOccurred(haptic)
                }
            }
    }
    
    private func onChanged(_ gesture: DragGesture.Value) {
        if offset.width > -15 {
            withAnimation(.smooth) {
                offset = gesture.translation
            }
        }
        timer?.invalidate()
    }
    
    private func onEnded(_ gesture: DragGesture.Value) {
        if offset.width > -100 && offset.width < 70 {
            withAnimation(.smooth) {
                offset = .zero
            }
        }
        
        if offset.width > 70 {
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
