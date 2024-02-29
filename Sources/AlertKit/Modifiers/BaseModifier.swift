//
// BaseModifier.swift
// AlertKit
// https://www.github.com/0xYanis/AlertKit
// See LICENSE for license information.
//

import SwiftUI

struct BaseModifier<Background, Figure>: ViewModifier where Background : ShapeStyle, Figure : Shape {
    var background: Background
    var shape: Figure
    var transition: AnyTransition
    
    init(
        background: Background,
        shape: Figure,
        transition: AnyTransition
    ) {
        self.background = background
        self.shape = shape
        self.transition = transition
    }
    
    func body(content: Content) -> some View {
        content
            .padding(12)
            .background(background)
            .clipShape(shape)
            .frame(maxWidth: .infinity)
            .transition(transition)
    }
}
