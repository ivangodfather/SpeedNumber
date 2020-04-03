//
//  Bundle+Version.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 03/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import Foundation

extension Bundle {
    var releaseVersion: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    var buildVersion: String {
        return infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
}
