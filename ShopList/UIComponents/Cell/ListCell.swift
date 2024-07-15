//
//  ListCell.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 12.07.2024.
//

import UIKit

class ListCell: UICollectionViewCell {
    //MARK: - Properties
    
    static var identifier: String = "ListCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .appDark
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.progressTintColor = .appGreen
        progressView.trackTintColor = .appGray
        progressView.layer.cornerRadius = 5
        progressView.clipsToBounds = true
        return progressView
    }()
    
    //MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    //MARK: - Setup
    
    private func setupViews() {
        backgroundColor = .appWhite
        layer.cornerRadius = 15

        contentView.addSubview(nameLabel)
        contentView.addSubview(progressView)
        
        nameLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
            make.height.equalTo(10)
        }
    }
    
    //MARK: - Configure
    
    func configure(with list: List) {
        nameLabel.text = list.name
        let totalProducts = list.products.count
        let progress = totalProducts == 0 ? 0 : 1
        progressView.setProgress(Float(progress), animated: false)
    }
}
