//
// AlertMessageItem.swift
// AlertKit
// https://www.github.com/0xYanis/AlertKit
// See LICENSE for license information.
//

import SwiftUI

struct AlertMessageItem<Background, Content>: View where Background : ShapeStyle, Content : View {
    @Binding private var isPresented: Bool
    private let background: Background
    @ViewBuilder private let content: () -> Content
    
    @State private var timer: Timer?
    @State private var offset = CGSize()
    
    private var timeInterval: TimeInterval = 5.0
    
    init(
        isPresented: SwiftUI.Binding<Bool>,
        background: Background,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.background = background
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
        .frame(minHeight: 90)
    }
    
    @ViewBuilder
    private var contentView: some View {
        content()
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .transition(.move(edge: .top).combined(with: .opacity))
            .offset(y: offset.height)
            .shadow(color: .black.opacity(0.15), radius: 10, x: 0, y: 0)
            .padding()
    }
    
    private func onChanged(_ gesture: DragGesture.Value) {
        if offset.height <= 40 {
            withAnimation(.interactiveSpring(response: 0.5, dampingFraction: 0.8)) {
                offset = gesture.translation
            }
        }
        timer?.invalidate()
    }
    
    private func onEnded(_ gesture: DragGesture.Value) {
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
