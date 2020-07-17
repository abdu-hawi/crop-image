//
//  UIView+Extentions.swift
//  Editor Crop Image
//
//  Created by Abdu macOS 15 on 26/11/1441 AH.
//  Copyright © 1441 Abdu macOS 15. All rights reserved.
//

import UIKit

extension UIView {    /// Create image snapshot of view.
    func snapshot(of rect: CGRect? = nil) -> UIImage {
        return UIGraphicsImageRenderer(bounds: rect ?? bounds).image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
}
