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
    
    @Binding var gameDuration: TimeInterval
    private let timer  = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Text(gameDuration.value.description)
                .font(Font.system(.largeTitle, design: .monospaced))
                .foregroundColor(Color.primary)
        }
        .onReceive(timer) { output in
            self.gameDuration += 0.01
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(gameDuration: .constant(3.3))
    }
}

extension TimeInterval {
    var value: String {
        String(format: "%.2f", self)
    }
}
