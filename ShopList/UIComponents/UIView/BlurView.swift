//
//  BlurView.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 12.07.2024.
//

import UIKit

class BlurView: UIVisualEffectView {
    
    var dismissAction: (() -> Void)?

    // Initializer
    override init(effect: UIVisualEffect?) {
        super.init(effect: effect)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        addGestureRecognizer(tapGesture)
        alpha = 0
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    @objc private func dismiss() {
        dismissAction?()
    }
}

