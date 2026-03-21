//
//  ProductsListView.swift
//  Study1
//
//  Created by Oleg Z on 09.03.2026.
//

import UIKit

class ProductsListView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var productsListData = ["Яйца", "Хлеб"]
    
    private lazy var productsLabel = UILabel()
    private lazy var productsList = UITableView()
    private lazy var addProductsButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productsList.dataSource = self
        productsList.delegate = self
        
        uiConfig()
        setup()
    }
    
    private func uiConfig() {
        view.backgroundColor = .lightGray
        tabBarItem.image = UIImage(systemName: "carrot")
        
        // Настройка productsLabel
        productsLabel.frame = CGRect(x: 40, y: 70, width: 200, height: 50)
        productsLabel.text = "Продукты"
        productsLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        productsLabel.textColor = .black
        
        // Настройка productsList
        productsList.frame = CGRect(x: 40, y: 150, width: 300, height: 480)
        productsList.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        productsList.rowHeight = 60
        productsList.backgroundColor = .white
        productsList.layer.cornerRadius = 15
        productsList.layer.masksToBounds = true
        productsList.clipsToBounds = true
        
        
        // Настройка addProductsButton
        addProductsButton.frame = CGRect(x: 40, y: 650, width: 300, height: 50)
        addProductsButton.setTitle("Добавить", for: .normal)
        addProductsButton.setTitleColor(.black, for: .normal)
        addProductsButton.layer.backgroundColor = UIColor.white.cgColor
        addProductsButton.layer.cornerRadius = 15
        addProductsButton.layer.masksToBounds = true
        addProductsButton.clipsToBounds = true
        
        //eatButton.addTarget(self, action: #selector(fetchTableData), for: .touchUpInside)
        
        
    }
    private func setup() {
        // Добавляем на экран
        view.addSubview(productsLabel)
        view.addSubview(productsList)
        view.addSubview(addProductsButton)
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productsListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = productsListData[indexPath.row]
        cell.accessoryType = .disclosureIndicator 
        return cell
    }
}
