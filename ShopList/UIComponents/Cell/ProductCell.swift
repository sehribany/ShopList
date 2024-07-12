//
//  ProductCell.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 5.07.2024.
//

import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    // MARK: - Properties
    
    static var identifier: String = "ProductCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius  = 10
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .appDark
        label.font = UIFont.systemFont(ofSize: 14)
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
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.appGray.cgColor
        layer.cornerRadius = 5
        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(5)
            make.height.equalTo(contentView.snp.width).multipliedBy(0.75)
        }
                
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(5)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalToSuperview().inset(5)
        }
    }
    
    // MARK: - Configure
    
    func configure(with product: Product) {
        nameLabel.text = product.name
        if let url = URL(string: product.image) {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "photo.circle.fill"))
        } else {
            imageView.image = UIImage(named: "photo.circle.fill")
        }
    }
}
