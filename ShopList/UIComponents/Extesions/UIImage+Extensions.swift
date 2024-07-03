//
//  UIImage+Extensions.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 2.07.2024.
//

import Foundation
import UIKit

extension UIImage{
    func resized(to size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage!
    }
}
