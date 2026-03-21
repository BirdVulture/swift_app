//
//  ChooseDish.swift
//  Study1
//
//  Created by Oleg Z on 10.03.2026.
//
import UIKit

class ChooseDish: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    
    weak var viewControllerDelegate: EatedDishDelegate?
    
    var chooseDishesListData = ["Бутер", "Кофе", "Пицца", "Пельмени", "Плов"]
    
    private lazy var chooseDishesLabel = UILabel()
    private lazy var chooseDishesList = UITableView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chooseDishesList.dataSource = self
        chooseDishesList.delegate = self
        uiConfig()
        setup()
    }
    
    private func uiConfig() {
        view.backgroundColor = .lightGray
        
        // Настройка chooseDishesLabel
        chooseDishesLabel.frame = CGRect(x: 40, y: 150, width: 200, height: 50)
        chooseDishesLabel.text = "Меню"
        chooseDishesLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        chooseDishesLabel.textColor = .black
        
        // Настройка chooseDishesList
        chooseDishesList.frame = CGRect(x: 40, y: 220, width: 300, height: 400)
        chooseDishesList.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        chooseDishesList.rowHeight = 60
        chooseDishesList.backgroundColor = .white
        chooseDishesList.layer.cornerRadius = 15
        chooseDishesList.layer.masksToBounds = true
        chooseDishesList.clipsToBounds = true
        
        

        
        
    }
    private func setup() {
        // Добавляем на экран
        view.addSubview(chooseDishesLabel)
        view.addSubview(chooseDishesList)
    }
    
    
        
    @objc private func goBackButton() {
        let vc = ChooseDish()
        navigationController?.pushViewController(vc, animated: true)
        }
        
        
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chooseDishesListData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = chooseDishesListData[indexPath.row]
        cell.accessoryType = .disclosureIndicator  //стрелочка в ячейке таблицы
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedDish = chooseDishesListData[indexPath.row]
        let vc = EatDish(dishName: selectedDish)
        vc.delegate = viewControllerDelegate  // ← ПРЯМО в ViewController!
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension ChooseDish: EatedDishDelegate {
    func eatDish(_ controller: EatDish, didCreate dish: any Dish) {
        viewControllerDelegate?.eatDish(controller, didCreate: dish)
        navigationController?.popViewController(animated: true)
    }
    
    func deleteEatedDish(_ controller: EditEatedDish, deleteRowAt index: Int) {
        print("ok")
    }
    
    func updateEatedDish(_ controller: EditEatedDish, updateRowAt index: Int, didUpdate dish: any Dish) {
        print("ok")
    }
}
