//
//  DishesView.swift
//  Study1
//
//  Created by Oleg Z on 09.03.2026.
//

import UIKit





class DishesListView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var dishesListData: [Dish] = [
        MenuDish(name: "Бутер", calory: 300, description: ""),
        MenuDish(name: "Кофе", calory: 50, description: "")
    ]
    
    private lazy var dishesLabel = UILabel()
    private lazy var dishesList = UITableView()
    private lazy var addDishButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dishesList.dataSource = self
        dishesList.delegate = self
        uiConfig()
        setup()
    }
    
    
    
    private func uiConfig() {
        view.backgroundColor = .lightGray
        
        // Настройка dishesLabel
        dishesLabel.frame = CGRect(x: 40, y: 70, width: 200, height: 50)
        dishesLabel.text = "Блюда"
        dishesLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        dishesLabel.textColor = .black
        
        // Настройка dishesList
        dishesList.frame = CGRect(x: 40, y: 150, width: 300, height: 480)
        dishesList.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        dishesList.rowHeight = 60
        dishesList.backgroundColor = .white
        dishesList.layer.cornerRadius = 15
        dishesList.layer.masksToBounds = true
        dishesList.clipsToBounds = true
        
        
        // Настройка addDishButton
        addDishButton.frame = CGRect(x: 40, y: 650, width: 300, height: 50)
        addDishButton.setTitle("Добавить блюдо", for: .normal)
        addDishButton.setTitleColor(.black, for: .normal)
        addDishButton.layer.backgroundColor = UIColor.white.cgColor
        addDishButton.layer.cornerRadius = 15
        addDishButton.layer.masksToBounds = true
        addDishButton.clipsToBounds = true
        
        addDishButton.addTarget(self, action: #selector(createNewDish), for: .touchUpInside)
        
        
    }
    private func setup() {
        // Добавляем на экран
        view.addSubview(dishesLabel)
        view.addSubview(dishesList)
        view.addSubview(addDishButton)
        
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishesListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let dish = dishesListData[indexPath.row]
        cell.textLabel?.text = "\(dish.name) (\(dish.calory) ккал)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    @objc private func createNewDish() {
        let newVC = AddDish()
        newVC.delegate = self
        navigationController?.pushViewController(newVC, animated: true)
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedDish = dishesListData[indexPath.row]
        let vc = EditDish(dishname: selectedDish.name, dishcalory: selectedDish.calory, rowIndex: indexPath.row)
        vc.delegate = self
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension DishesListView: MenuDishDelegate {
    func addDish(_ controller: AddDish, didCreate dish: any Dish) {
        dishesListData.append(dish)
        dishesList.reloadData()
    }
    
    func deleteDish(_ controller: EditDish, deleteRowAt index: Int) {
            dishesListData.remove(at: index)  // ← Удаляем из массива
            dishesList.reloadData()           // ← Обновляем таблицу
    }
    
    func updateDish(_ controller: EditDish, updateRowAt index: Int, didUpdate dish: any Dish) {
        dishesListData[index] = dish
        //dishesListData.insert(dish, at: index)
        dishesList.reloadData()
    }
    
}
