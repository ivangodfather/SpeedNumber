//
//  View+Font.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 07/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI

private var dessing: Font.Design {
    return .monospaced
}

struct LargeTitleLabel: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(.largeTitle, design: dessing))
    }
}

struct BodyLabel: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(.body, design: dessing))
    }
}

struct FootNodeLabel: ViewModifier {
    func body(content: Content) -> some View {
        content.font(Font.system(.footnote, design: dessing))
    }
}

struct DefaultButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.system(.headline, design: dessing))
            .foregroundColor(Color(.label))
    }
}
