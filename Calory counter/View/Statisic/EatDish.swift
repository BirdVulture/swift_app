//
//  EatDish.swift
//  Study1
//
//  Created by Oleg Z on 10.03.2026.
//

import UIKit

class EatDish: UIViewController {
    
    weak var delegate: EatedDishDelegate?
    
    private var dishName: String
    private var dishCalory: Int = 100
    
    private lazy var dishNameField = UILabel()
    
    private lazy var quantityCounterLabel = UILabel()
    private lazy var quantityCounterDescription = UILabel()
    private lazy var dishCaloryField = UILabel()
    
    private lazy var addQuantityButton = UIButton(type: .system)
    private lazy var removeQuantityButton = UIButton(type: .system)
    private lazy var eatDishButton = UIButton(type: .system)
    
    init(dishName: String) {
        self.dishName = dishName
        super.init(nibName: nil, bundle: nil)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiConfig()
        setup()
    }
    
    private func uiConfig() {
        view.backgroundColor = .lightGray
        
        // Настройка dishNameField
        dishNameField.frame = CGRect(x: 20, y: 150, width: 340, height: 80)
        dishNameField.text = String(dishName)
        dishNameField.font = UIFont.systemFont(ofSize: 35, weight: .bold)
        dishNameField.textColor = .black
        
        
        dishNameField.layer.cornerRadius = 15
        
        // Настройка dishCaloryField
        dishCaloryField.frame = CGRect(x: 100, y: 300, width: 300, height: 150)
        dishCaloryField.text = String(dishCalory)
        dishCaloryField.font = UIFont.systemFont(ofSize: 80, weight: .medium)
        dishCaloryField.textColor = .black
        
        // Настройка quantityCounterLabel
        quantityCounterLabel.frame = CGRect(x: 250, y: 370, width: 100, height: 50)
        quantityCounterLabel.text = "граммов"
        quantityCounterLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        quantityCounterLabel.textColor = .black
        
        // Настройка quantityCounterDescription
        quantityCounterDescription.frame = CGRect(x: 30, y: 280, width: 350, height: 50)
        quantityCounterDescription.text = "Укажите вес порции"
        quantityCounterDescription.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        quantityCounterDescription.textColor = .black
        
        // Настройка eatDishButton
        eatDishButton.frame = CGRect(x: 45, y: 650, width: 300, height: 50)
        eatDishButton.setTitle("Съедено", for: .normal)
        eatDishButton.setTitleColor(.black, for: .normal)
        eatDishButton.layer.backgroundColor = UIColor.white.cgColor
        eatDishButton.layer.cornerRadius = 15
        eatDishButton.layer.masksToBounds = true
        eatDishButton.clipsToBounds = true
        
        eatDishButton.addTarget(self, action: #selector(saveAndGoBack), for: .touchUpInside)
        
        // Настройка addQuantityButton
        addQuantityButton.frame = CGRect(x: 200, y: 500, width: 140, height: 50)
        addQuantityButton.setTitle("+", for: .normal)
        addQuantityButton.setTitleColor(.black, for: .normal)
        addQuantityButton.layer.backgroundColor = UIColor.white.cgColor
        addQuantityButton.layer.cornerRadius = 15
        addQuantityButton.layer.masksToBounds = true
        addQuantityButton.clipsToBounds = true
        
        addQuantityButton.addTarget(self, action: #selector(addQuatity), for: .touchUpInside)
        
        // Настройка removeQuantityButton
        removeQuantityButton.frame = CGRect(x: 40, y: 500, width: 140, height: 50)
        removeQuantityButton.setTitle("-", for: .normal)
        removeQuantityButton.setTitleColor(.black, for: .normal)
        removeQuantityButton.layer.backgroundColor = UIColor.white.cgColor
        removeQuantityButton.layer.cornerRadius = 15
        removeQuantityButton.layer.masksToBounds = true
        removeQuantityButton.clipsToBounds = true
        
        removeQuantityButton.addTarget(self, action: #selector(removeQuatity), for: .touchUpInside)
    }
    
    private func setup() {
        // Добавляем на экран
        view.addSubview(dishNameField)
        view.addSubview(dishCaloryField)
        view.addSubview(quantityCounterLabel)
        view.addSubview(addQuantityButton)
        view.addSubview(removeQuantityButton)
        view.addSubview(quantityCounterDescription)
        view.addSubview(eatDishButton)
    }
    
    @objc private func addQuatity() {
        if dishCalory < 950 {
            dishCalory += 25
            dishCaloryField.text = String(dishCalory)
        }
    }
    @objc private func removeQuatity() {
        if dishCalory > 0 {
            dishCalory -= 25
            dishCaloryField.text = String(dishCalory)
        }
    }
    @objc private func saveAndGoBack() {
        let dish = MenuDish(name: dishNameField.text ?? "None", calory: dishCalory, description: "" )
        delegate?.eatDish(self, didCreate: dish)
        navigationController?.popViewController(animated: true)
        }
    
}

