//
// Color+AlertExtensions.swift
// AlertKit
// https://www.github.com/0xYanis/AlertKit
// See LICENSE for license information.
//

import SwiftUI

extension Color {
    static var alertColor: Color {
#if os(iOS)
        Color(.secondarySystemBackground)
#else
        Color(.gray)
#endif
    }
}
