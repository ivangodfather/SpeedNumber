//
//  Int+.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 02/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension Int64 {
    var score: String {
        String(Double(self) / 100)
    }
}
