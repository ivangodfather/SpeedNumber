//
//  TimerView.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 01/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import SwiftUI
import Combine

struct TimerView: View {
    private let timer  = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    private var gameDuration: Binding<TimeInterval>
    private let isActive: Bool
    
    init(_ gameDuration: Binding<TimeInterval>, isActive: Bool) {
        self.gameDuration = gameDuration
        self.isActive = isActive
    }
    
    var body: some View {
        VStack {
            Text(gameDuration.wrappedValue.value)
                .font(Font.system(.largeTitle, design: .monospaced))
                .foregroundColor(Color.primary)
        }
        .onReceive(timer) { output in
            if self.isActive {
                self.gameDuration.wrappedValue += 0.1
            } else {
                self.timer.upstream.connect().cancel()
            }
            
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(.constant(0), isActive: true)
    }
}

extension TimeInterval {
    var value: String {
        String(format: "%.1f", self)
    }
}
