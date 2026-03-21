//
//  EditDish.swift
//  Study1
//
//  Created by Oleg Z on 13.03.2026.
//



import UIKit

class EditDish: UIViewController, UITextFieldDelegate {
    
    weak var delegate: MenuDishDelegate?
    
    private var dishName: String
    private var dishCalory: Int
    private var rowIndex: Int
    
    private lazy var dishNameField = UITextField()
    private lazy var caloryCounterLabel = UILabel()
    private lazy var caloryCounterDescription = UILabel()
    private lazy var dishCaloryField = UILabel()
    private lazy var addCaloryButton = UIButton(type: .system)
    private lazy var removeCaloryButton = UIButton(type: .system)
    private lazy var createDishButton = UIButton(type: .system)
    private lazy var deleteDishButton = UIButton(type: .system)
    
    
    init(dishname: String, dishcalory: Int,  rowIndex: Int) {
        self.dishName = dishname
        self.dishCalory = dishcalory
        self.rowIndex = rowIndex
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
        dishNameField.placeholder = "Введите название"
        dishNameField.backgroundColor = .white
        dishNameField.layer.cornerRadius = 15
        dishNameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: dishNameField.frame.height))
        dishNameField.leftViewMode = .always
        
        dishNameField.returnKeyType = .done          // кнопка "Готово"
        dishNameField.delegate = self                // ВАЖНО: делегат
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        // Настройка dishCaloryField
        dishCaloryField.frame = CGRect(x: 100, y: 300, width: 300, height: 150)
        dishCaloryField.text = String(dishCalory)
        dishCaloryField.font = UIFont.systemFont(ofSize: 80, weight: .medium)
        dishCaloryField.textColor = .black
        
        // Настройка caloryCounterLabel
        caloryCounterLabel.frame = CGRect(x: 300, y: 370, width: 50, height: 50)
        caloryCounterLabel.text = "кКал"
        caloryCounterLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        caloryCounterLabel.textColor = .black
        
        // Настройка caloryCounterDescription
        caloryCounterDescription.frame = CGRect(x: 30, y: 280, width: 350, height: 50)
        caloryCounterDescription.text = "Укажите калорийность для 100 г. блюда"
        caloryCounterDescription.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        caloryCounterDescription.textColor = .black
        
        // Настройка createDishButton
        createDishButton.frame = CGRect(x: 40, y: 650, width: 300, height: 50)
        createDishButton.setTitle("Сохранить", for: .normal)
        createDishButton.setTitleColor(.black, for: .normal)
        createDishButton.layer.backgroundColor = UIColor.white.cgColor
        createDishButton.layer.cornerRadius = 15
        createDishButton.layer.masksToBounds = true
        createDishButton.clipsToBounds = true
        
        createDishButton.addTarget(self, action: #selector(updateAndGoBack), for: .touchUpInside)
        
        // Настройка deleteDishButton
        deleteDishButton.frame = CGRect(x: 40, y: 580, width: 300, height: 50)
        deleteDishButton.setTitle("Удалить", for: .normal)
        deleteDishButton.setTitleColor(.black, for: .normal)
        deleteDishButton.layer.backgroundColor = UIColor.red.cgColor
        deleteDishButton.layer.cornerRadius = 15
        deleteDishButton.layer.masksToBounds = true
        deleteDishButton.clipsToBounds = true
        
        deleteDishButton.addTarget(self, action: #selector(deleteAndGoBack), for: .touchUpInside)
        
        // Настройка addCaloryButton
        addCaloryButton.frame = CGRect(x: 200, y: 500, width: 140, height: 50)
        addCaloryButton.setTitle("+", for: .normal)
        addCaloryButton.setTitleColor(.black, for: .normal)
        addCaloryButton.layer.backgroundColor = UIColor.white.cgColor
        addCaloryButton.layer.cornerRadius = 15
        addCaloryButton.layer.masksToBounds = true
        addCaloryButton.clipsToBounds = true
        
        addCaloryButton.addTarget(self, action: #selector(addCalory), for: .touchUpInside)
        
        // Настройка removeCaloryButton
        removeCaloryButton.frame = CGRect(x: 40, y: 500, width: 140, height: 50)
        removeCaloryButton.setTitle("-", for: .normal)
        removeCaloryButton.setTitleColor(.black, for: .normal)
        removeCaloryButton.layer.backgroundColor = UIColor.white.cgColor
        removeCaloryButton.layer.cornerRadius = 15
        removeCaloryButton.layer.masksToBounds = true
        removeCaloryButton.clipsToBounds = true
        
        removeCaloryButton.addTarget(self, action: #selector(removeCalory), for: .touchUpInside)
        
        
    }
    private func setup() {
        // Добавляем на экран
        view.addSubview(dishNameField)
        view.addSubview(dishCaloryField)
        view.addSubview(createDishButton)
        view.addSubview(caloryCounterLabel)
        view.addSubview(addCaloryButton)
        view.addSubview(removeCaloryButton)
        view.addSubview(caloryCounterDescription)
        view.addSubview(deleteDishButton)
    }
    
    @objc private func addCalory() {
        if dishCalory < 3000 {
            dishCalory += 50
            dishCaloryField.text = String(dishCalory)
        }
    }
    @objc private func removeCalory() {
        if dishCalory > 0 {
            dishCalory -= 50
            dishCaloryField.text = String(dishCalory)
        }
    }
    
    
    
    @objc private func hideKeyboard() {
        view.endEditing(true)   // убирает фокус со всех текстовых полей
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()   // скрыть клавиатуру
            return true
        }
    
    @objc private func deleteAndGoBack() {
        _ = MenuDish(name: dishNameField.text ?? "None", calory: dishCalory, description: "" )
        delegate?.deleteDish(self, deleteRowAt: rowIndex)
        navigationController?.popViewController(animated: true)
        }
    @objc private func updateAndGoBack() {
        let dish = MenuDish(name: dishNameField.text ?? "None", calory: dishCalory, description: "" )
        delegate?.updateDish(self, updateRowAt: rowIndex, didUpdate: dish)
        navigationController?.popViewController(animated: true)
        }
}

