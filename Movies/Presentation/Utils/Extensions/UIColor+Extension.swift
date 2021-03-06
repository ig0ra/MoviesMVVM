// UIColor+Extension.swift
// Copyright © Igor Obrizko. All rights reserved.

import UIKit

extension UIColor {
    static func random() -> UIColor {
        UIColor(
            red: .random(),
            green: .random(),
            blue: .random(),
            alpha: 1.0
        )
    }
}
