//
//  UICollectionView+Extensions.swift
//  Weather
//
//  Created by Danylo Safronov on 07.07.2022.
//

import Foundation
import UIKit

extension UICollectionView {
    func register<ReusableClass>(_ class: ReusableClass.Type, of kind: String) where ReusableClass: UICollectionReusableView {
        register(
            `class`,
            forSupplementaryViewOfKind: kind,
            withReuseIdentifier: `class`.resolveReusableIdentifier()
        )
    }
    
    func dequeue<ReusableClass>(_ class: ReusableClass.Type, of kind: String, for index: IndexPath) -> ReusableClass where ReusableClass: UICollectionReusableView {
        dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: `class`.resolveReusableIdentifier(),
            for: index
        ) as! ReusableClass
    }
    
    func register<CellCalss>(_ class: CellCalss.Type) where CellCalss: UICollectionViewCell {
        register(
            `class`,
            forCellWithReuseIdentifier: `class`.resolveReusableIdentifier()
        )
    }
    
    func dequeue<CellCalss>(_ class: CellCalss.Type, for index: IndexPath) -> CellCalss where CellCalss: UICollectionViewCell {
        dequeueReusableCell(
            withReuseIdentifier: `class`.resolveReusableIdentifier(),
            for: index
        ) as! CellCalss
    }
}
