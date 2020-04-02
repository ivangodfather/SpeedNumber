//
//  TileView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct TileView: View {
    var x, y, value: Int
    var completion: () -> ()
    
    var body: some View {
        Button(action: { self.completion() }) {
            Rectangle()
                .fill(Color(UIColor.systemBackground))
                .border(Color.primary, width: value == 0 ? 0: 2)
                .overlay(
                    Text(value > 0 ? value.description : "")
                        .foregroundColor(.primary)
                        .font(Font.system(size: 23, weight: .medium, design: .monospaced))
            )
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        TileView(x: 1, y: 1, value: 1, completion: {})
    }
}
