//
//  CurrentValueView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct CurrentValueView: View {
    var currentValue: Int
    var body: some View {
        Text(currentValue.description)
            .font(Font.system(size: 56, weight: .semibold, design: .monospaced))
            .foregroundColor(Color.primary)
    }
}

struct CurrentValueView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentValueView(currentValue: 4)
    }
}
