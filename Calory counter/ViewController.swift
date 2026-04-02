//
//  ViewController.swift
//  Study1
//
//  Created by Oleg Z on 07.03.2026.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    private lazy var caloryCounter = 2300
    var eatedDishesList: [Dish] = [
        MenuDish(name: "Бутер", calory: 300, description: ""),
        MenuDish(name: "Кофе", calory: 50, description: "")
    ]
    
    private lazy var caloryCounterField = UILabel()
    private lazy var caloryCounterLabel = UILabel()
    private lazy var dateLabel = UILabel()
    private lazy var firstButton = UIButton(type: .system)
    private lazy var removeButton = UIButton(type: .system)
    private lazy var foodHistoryTable = UITableView()
    private lazy var eatButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        foodHistoryTable.dataSource = self
        foodHistoryTable.delegate = self
        uiConfig()
        setup()
        
    }
    
    
    
    private func uiConfig() {
        view.backgroundColor = .lightGray
        
        // Настройка foodHistoryTable
        foodHistoryTable.frame = CGRect(x: 45, y: 200, width: 300, height: 430)
        foodHistoryTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        foodHistoryTable.rowHeight = 60
        foodHistoryTable.backgroundColor = .white
        foodHistoryTable.layer.cornerRadius = 15
        foodHistoryTable.layer.masksToBounds = true
        foodHistoryTable.clipsToBounds = true
        
        
        // Настройка caloryCounterField
        caloryCounterField.frame = CGRect(x: 20, y: 100, width: 200, height: 50)
        caloryCounterField.text = String(caloryCounter)
        caloryCounterField.font = UIFont.systemFont(ofSize: 60, weight: .bold)
        caloryCounterField.textColor = .black
        
        // Настройка caloryCounterLabel
        caloryCounterLabel.frame = CGRect(x: 200, y: 110, width: 200, height: 50)
        caloryCounterLabel.text = "кКал"
        caloryCounterLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        caloryCounterLabel.textColor = .black
        
        // Настройка dateLabel
        dateLabel.frame = CGRect(x: 130, y: 50, width: 200, height: 50)
        dateLabel.text = "7 марта 2026"
        dateLabel.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        dateLabel.textColor = .black
        
        // Настройка firstButton
        firstButton.frame = CGRect(x: 45, y: 650, width: 300, height: 50)
        firstButton.setTitle("Съесть что нибудь", for: .normal)
        firstButton.setTitleColor(.black, for: .normal)
        firstButton.layer.backgroundColor = UIColor.white.cgColor
        firstButton.layer.cornerRadius = 15
        firstButton.layer.masksToBounds = true
        firstButton.clipsToBounds = true
        
        firstButton.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }
        
    private func setup() {
        
        // Добавляем на экран
        view.addSubview(caloryCounterField)
        view.addSubview(caloryCounterLabel)
        view.addSubview(dateLabel)
        view.addSubview(firstButton)
        view.addSubview(foodHistoryTable)
        //view.addSubview(eatButton)
    }
    
    
    
    @objc private func goNext() {
        let newVC = ChooseDish()
        newVC.viewControllerDelegate = self  // ← Прямой доступ
        navigationController?.pushViewController(newVC, animated: true)
        }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return eatedDishesList.count
        }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let dish = eatedDishesList[indexPath.row]
        cell.textLabel?.text = "\(dish.name) (\(dish.calory) ккал)"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedDish = eatedDishesList[indexPath.row]
        let vc = EditEatedDish(dishname: selectedDish.name, dishcalory: selectedDish.calory, rowIndex: indexPath.row)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ViewController: EatedDishDelegate {
    func eatDish(_ controller: EatDish, didCreate dish: any Dish) {
        print("ok")
        eatedDishesList.append(dish)
        foodHistoryTable.reloadData()
        print("ok")
    }
    
    func deleteEatedDish(_ controller: EditEatedDish, deleteRowAt index: Int) {
        eatedDishesList.remove(at: index)  // ← Удаляем из массива
        foodHistoryTable.reloadData()
    }
    
    func updateEatedDish(_ controller: EditEatedDish, updateRowAt index: Int, didUpdate dish: any Dish) {
        eatedDishesList[index] = dish
        foodHistoryTable.reloadData()
    }
    
    
}
