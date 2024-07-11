//
//  ListViewController.swift
//  ShopList
//
//  Created by Şehriban Yıldırım on 2.07.2024.
//

import UIKit
import SnapKit

class ListViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .appDark
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setTitle("New List", for: .normal)
        button.tintColor = .appWhite
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var createListView = CreateListView()
    private lazy var blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    private var viewModel = ListViewModel()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationBar()
        registerForKeyboardNotifications()
    }
        
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - setupUI & setupNavigationBar
extension ListViewController{
    
    private func setupUI(){
        view.backgroundColor = .appBackground
        setupAddButton()
        setupBlurEffectView()
        setupCreateListView()
    }
    
    private func setupAddButton(){
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.trailing.equalTo(view).offset(-20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-100)
        }
    }
    
    private func setupBlurEffectView() {
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.alpha = 0
        view.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    private func setupCreateListView(){
        createListView.layer.cornerRadius = 15
        view.addSubview(createListView)
        createListView.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(view).multipliedBy(0.8)
            make.height.equalTo(150)
        }
        
        createListView.isHidden = true
        createListView.createButtonAction = { [weak self] listName in
            self?.saveList(name: listName)
        }
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "My Lists"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.appDark]
    }
}

//MARK: - Action
extension ListViewController{
    
    @objc private func addButtonTapped() {
        createListView.isHidden = false
        createListView.showKeyboard()
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 1
        }
    }
    
    private func dismissPopupView() {
        createListView.isHidden = true
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 0
        }
    }
    
    private func saveList(name: String?) {
        guard let name = name, !name.isEmpty else {return}
    
        viewModel.saveList(name: name) { [weak self] error in
            if let error = error {
                print("Error saving list: \(error)")
            } else {
                print("List saved successfully")
                self?.createListView.hideKeyboard()
                self?.dismissPopupView()
            }
        }
    }
    
    //MARK: - Keyboard
    
    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        
        createListView.snp.updateConstraints { make in
            make.centerY.equalTo(view).offset(-keyboardHeight / 2)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        createListView.snp.updateConstraints { make in
            make.centerY.equalTo(view)
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

#Preview{
    ListViewController()
}
