//
//  CreateListView.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 3.07.2024.
//

import UIKit
import SnapKit

class CreateListView: UIView {
    
    // MARK: - Properties
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter list name"
        textField.textColor = .appDark
        textField.borderStyle = .roundedRect
        textField.layer.cornerRadius = 10
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .appDark
        button.tintColor = .appWhite
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(createButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var createButtonAction: ((String?) -> Void)?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - SetupUI
    
    private func setupUI() {
        backgroundColor = .appWhite
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(40)
        }
        
        addSubview(createButton)
        createButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.leading.equalTo(self).offset(20)
            make.trailing.equalTo(self).offset(-20)
            make.height.equalTo(40)
        }
    }
    
    // MARK: - Actions
    
    @objc private func createButtonTapped() {
        createButtonAction?(textField.text)
    }
    
    func showKeyboard() {
        textField.becomeFirstResponder()
    }
    
    func hideKeyboard() {
        textField.resignFirstResponder()
    }
}
