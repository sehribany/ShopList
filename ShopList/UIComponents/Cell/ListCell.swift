//
//  ListCell.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 12.07.2024.
//

import UIKit

class ListCell: UICollectionViewCell {
    // MARK: - Properties
    
    static var identifier: String = "ListCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .appDark
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    // MARK: - Setup
    
    private func setupViews() {
        backgroundColor = .appWhite
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Configure
    
    func configure(with list: List) {
        nameLabel.text = list.name
    }
}
