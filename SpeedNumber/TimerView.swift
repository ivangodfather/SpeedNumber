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
    @ObservedObject var timer = MyTimer()
    
    var body: some View {
        VStack {
            Text(timer.time.value)
                .font(Font.system(.largeTitle, design: .monospaced))
                .foregroundColor(Color.primary)
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

extension TimeInterval {
    var value: String {
        String(format: "%.1f", self)
    }
}


class MyTimer: ObservableObject {
    var timer: Timer?
    @Published var time: TimeInterval = 0
    private let increment = 0.1
    
    @objc func updateCounter() {
        time += increment
    }
    
    init() {
        timer = Timer.scheduledTimer(timeInterval: increment,
                                     target: self,
                                     selector:#selector(updateCounter),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    func killTimer() {
        timer?.invalidate()
        timer = nil
    }
}
