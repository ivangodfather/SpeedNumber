//
//  Locale+Country.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 07/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension Locale {
    var isSpain: Bool {
        (Locale.current.regionCode == "ES") || (Locale.current.description.contains("ES"))
    }
}
