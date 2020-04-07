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
    @Environment(\.gridSize) private var gridSize
    
    private var totalGridCount: Int {
        return gridSize * gridSize
    }
    
    var body: some View {
        Button(action: { self.completion() }) {
            Rectangle()
                .fill(computeColor())
                .overlay(
                    Text(value > 0 ? value.description : "")
                        .foregroundColor(.primary)
                        .font(Font.system(size: 48, design: .monospaced))
            )
            
        }
    }
    
    private func computeColor() -> Color {
        guard value != 0 else { return .clear }
        return Color(.systemTeal).opacity(value > totalGridCount ? 1 : 0.5)
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                TileView(x: 1, y: 1, value: 1, completion: {})
                    .environment(\.colorScheme, .dark)
                TileView(x: 1, y: 1, value: 2, completion: {})
            }
            .environment(\.colorScheme, .light)
            HStack {
                TileView(x: 1, y: 1, value: 3, completion: {})
                    .environment(\.colorScheme, .dark)
                TileView(x: 1, y: 1, value: 4, completion: {})
            }
            .environment(\.colorScheme, .dark)

        }.background(Color(UIColor.systemBackground))

    }
}
