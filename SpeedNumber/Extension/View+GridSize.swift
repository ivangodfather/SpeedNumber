//
//  View+.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 03/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation
import SwiftUI

extension View {
    func gridSize(_ size: Int) -> some View {
        return environment(\.gridSize, size)
    }
}

extension EnvironmentValues {
    var gridSize: Int {
        get { self[GridSizeKey] }
        set { self[GridSizeKey] = newValue }
    }
}

struct GridSizeKey: EnvironmentKey {
    static var defaultValue: Int {
        #if DEBUG
            return 5
        #else
            return 5
        #endif
    }
}
