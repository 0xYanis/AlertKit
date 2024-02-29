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
    private var content: () -> Content
    
    init(
        isPresented: SwiftUI.Binding<Bool>,
        timeInterval: TimeInterval = 3,
        shape: Figure,
        background: Background,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.content = content
        self.timeInterval = timeInterval
        self.shape = shape
        self.background = background
    }
    
    var body: some View {
        GeometryReader { _ in
            ZStack {
                if isPresented {
                    contentView
                }
            }
            .gesture(
                DragGesture()
                    .onChanged(onChange(_:))
                    .onEnded { _ in onEnd() }
            )
            .onChange(of: isPresented) { newValue in
                if newValue {
                    resetTimer()
                } else {
                    timer?.invalidate()
                }
            }
        }
        .animation(.easeIn(duration: 0.2), value: isPresented)
    }
    
    private var contentView: some View {
        content()
            .modifier(BaseModifier(
                background: background,
                shape: shape,
                transition: .move(edge: .top)
                    .combined(with: .scale(scale: 0.7))
                    .combined(with: .opacity)))
            .offset(y: offset.height)
    }
    
    private func onChange(_ gesture: DragGesture.Value) {
        if offset.height <= 40 {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)) {
                offset = gesture.translation
            }
        }
        timer?.invalidate()
    }
    
    private func onEnd() {
        if offset.height > 0 {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)) {
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
        withAnimation(.easeInOut) {
            isPresented = false
            timer?.invalidate()
            offset = .zero
        }
    }
}
