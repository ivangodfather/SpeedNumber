//
//  TimeInterval+Score.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension TimeInterval {
    var score: String {
        String(format: "%.2f", self)
    }
}
