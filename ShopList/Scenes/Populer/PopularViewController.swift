//
//  PopularViewController.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 1.07.2024.
//
import UIKit
import SnapKit

class PopularViewController: UIViewController {
    
    //MARK: - Properties
    
    lazy private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.itemSize = CGSize(width: 100, height: 120)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .appBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        return collectionView
    }()
    
    lazy private var productsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .appBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        return collectionView
    }()
    
    private var viewModel = CategoryViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        configureContents()
        fetchCategories()
    }
    
    // MARK: - Data Fetch
    
    private func fetchCategories() {
        viewModel.fetchCategories {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    private func fetchProducts(for categoryID: Int) {
        viewModel.fetchProducts(categoryID: categoryID) {
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
        }
    }
    
    // MARK: - UILayout and Configuration
    
    private func addSubViews(){
        setupCollectionView()
        setupProductsCollectionView()
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(140)
        }
    }
    
    private func setupProductsCollectionView() {
        view.addSubview(productsCollectionView)
        
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
    
    private func configureContents(){
        view.backgroundColor = .appBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        productsCollectionView.dataSource = self
        productsCollectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource and UICollectionViewDelegate

extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.collectionView {
            return viewModel.categories.count
        } else {
            return viewModel.products.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.collectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
            let category = viewModel.categories[indexPath.item]
            cell.configure(with: category)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
            cell.layer.borderWidth = 0.5
            cell.layer.borderColor = UIColor.appGray.cgColor
            cell.layer.cornerRadius = 5
            let product = viewModel.products[indexPath.item]
            cell.configure(with: product)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView {
            let category = viewModel.categories[indexPath.item]
            fetchProducts(for: category.id)
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension PopularViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == productsCollectionView {
            let width = (collectionView.frame.width - 30) / 2 
            return CGSize(width: width, height: width * 1.3)
        } else {
            return CGSize(width: 100, height: 120)
        }
    }
}
