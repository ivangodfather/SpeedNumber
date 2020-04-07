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
    
    @State private var hasAppeared = false
    var body: some View {
        Text(currentValue.description)
            .font(Font.system(size: 88, design: .monospaced))
            .foregroundColor(Color.primary)
            .scaleEffect(CGFloat(currentValue))
            .animation(.default)
            .onAppear {
                print("hey ya")
        }.onDisappear {
            print("out")
        }
    }
}

struct CurrentValueView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentValueView(currentValue: 4)
    }
}

extension AnyTransition {
  static var customTransition: AnyTransition {
    let transition = AnyTransition.move(edge: .top)
      .combined(with: .scale(scale: 0.2, anchor: .topTrailing))
      .combined(with: .opacity)
    return transition
  }
}
