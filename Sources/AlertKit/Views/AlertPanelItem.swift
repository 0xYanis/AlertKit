//
// AlertPanelItem.swift
// AlertKit
// https://www.github.com/0xYanis/AlertKit
// See LICENSE for license information.
//

import SwiftUI

struct AlertPanelItem<Content, Background>: View where Content : View, Background : ShapeStyle {
    @Binding private var isPresented: Bool
    private var background: Background
    private var transition: AnyTransition
    private var content: () -> Content
    
    init(
        isPresented: SwiftUI.Binding<Bool>,
        background: Background,
        transition: AnyTransition,
        @ViewBuilder content: @escaping () -> Content
    ) {
        self._isPresented = isPresented
        self.background = background
        self.transition = transition
        self.content = content
    }
    
    var body: some View {
        ZStack {
            if isPresented {
                Color.black
                    .opacity(0.2)
                    .ignoresSafeArea()
                    .onTapGesture(perform: hide)
                ZStack {
                    content()
                }
                .padding(12)
                .frame(maxWidth: .infinity)
                .background(background)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .black.opacity(0.1), radius: 20)
                .padding()
                .padding(.horizontal)
                .transition(transition)
            }
        }
        .animation(.easeInOut(duration: 0.2), value: isPresented)
    }
    
    private func hide() {
        isPresented = false
    }
}
