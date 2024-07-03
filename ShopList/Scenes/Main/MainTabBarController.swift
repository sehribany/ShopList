//
//  MainTabBarController.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 2.07.2024.
//

import UIKit
import SnapKit

class MainTabBarController: UITabBarController {
    
    //MARK: - Properties

    private lazy var customTabBarView: UIView = {
        let view = UIView()
        view.backgroundColor = .appWhite
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var circleView: UIView = {
        let view = UIView()
        view.backgroundColor = .appDark
        view.layer.cornerRadius = 35
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var basketIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = .troller.resized(to: CGSize(width: 35, height: 35)).withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .appWhite
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBarUI()
        setupViewControllers()
    }
    
    // MARK: - Tab Bar UI Setup

    private func setupTabBarUI() {
        tabBar.tintColor = .appGreen
        tabBar.backgroundColor = .clear
        tabBar.isTranslucent = true
        
        tabBar.addSubview(customTabBarView)
        customTabBarView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        }
        
        tabBar.addSubview(circleView)
        circleView.snp.makeConstraints { make in
            make.width.height.equalTo(70)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(-20)
        }
        
        circleView.addSubview(basketIcon)
        basketIcon.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(40)
        }
    }
    
    // MARK: - View Controllers Setup
    
    private func setupViewControllers() {
        viewControllers = [
            createNavigationController(for: ListViewController(), imageName: "list.clipboard"),
            createNavigationController(for: BasketViewController()),
            createNavigationController(for: ProfileViewController(), imageName: "person.crop.circle")
        ]
    }
    
    private func createNavigationController(for rootViewController: UIViewController, imageName: String? = nil) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootViewController)
        if let imageName = imageName {
            navController.tabBarItem.image = UIImage(systemName: imageName)?.resized(to: CGSize(width: 35, height: 35))
        }
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0)
        return navController
    }
}

#Preview{
    MainTabBarController()
}
