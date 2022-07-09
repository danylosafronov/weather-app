//
//  UICollectionReusableView+Extensions.swift
//  Weather
//
//  Created by Danylo Safronov on 08.07.2022.
//

import Foundation
import UIKit

extension UICollectionReusableView {
    static func resolveReusableIdentifier() -> String {
        String(describing: self)
    }
}
