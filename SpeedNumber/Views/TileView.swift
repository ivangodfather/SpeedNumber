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
                .fill(Color.accentColor.opacity(value > 25 ? 0.8 : 0.2))
                .border(Color.primary, width: value == 0 ? 0: 2)
                .overlay(
                    Text(value > 0 ? value.description : "")
                        .foregroundColor(.primary)
                        .font(Font.system(size: 48, weight: .medium, design: .monospaced))
            )
            
        }
    }
}

struct TileView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                TileView(x: 1, y: 1, value: 35, completion: {})
                    .environment(\.colorScheme, .dark)
                TileView(x: 1, y: 1, value: 2, completion: {})
            }
            .environment(\.colorScheme, .light)
            HStack {
                TileView(x: 1, y: 1, value: 35, completion: {})
                    .environment(\.colorScheme, .dark)
                TileView(x: 1, y: 1, value: 2, completion: {})
            }
            .environment(\.colorScheme, .dark)

        }.background(Color(UIColor.systemBackground))

    }
}
