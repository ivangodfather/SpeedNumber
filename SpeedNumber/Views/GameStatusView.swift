//
//  GameStatusView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI

struct GameStatusView: View {
    
    @Binding var gameDuration: TimeInterval
    var currentValue: Int
    @Binding var scale: Bool

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Image(systemName: "timer")
                    .imageScale(.large)
                .foregroundColor(Color(.systemPink))
                TimerView(gameDuration: self.$gameDuration)
            }
            HStack {
                Image(systemName: "number")
                    .imageScale(.large)
                .foregroundColor(Color(.systemPink))

                CurrentValueView(currentValue: currentValue)
            }.scaleEffect(scale ? 1.5 : 1)
        }.padding(.top, 32)
    }
}

struct GameStatusView_Previews: PreviewProvider {
    static var previews: some View {
        GameStatusView(gameDuration: .constant(3), currentValue: 2, scale: .constant(false))
    }
}
