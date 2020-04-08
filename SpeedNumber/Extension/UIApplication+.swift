//
//  UIApplication+.swift
//  SpeedNumber
//
//  Created by Ivan Ruiz Monjo on 08/04/2020.
//  Copyright © 2020 Ivan Ruiz Monjo. All rights reserved.
//

import UIKit

extension UIApplication {
    func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
             return
         }

         if UIApplication.shared.canOpenURL(settingsUrl) {
             UIApplication.shared.open(settingsUrl, completionHandler: nil)
         }
    }
}
