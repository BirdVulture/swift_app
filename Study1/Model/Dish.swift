//
//  dish.swift
//  Study1
//
//  Created by Oleg Z on 09.03.2026.
//

import Foundation



class MenuDish: Dish {
    var id: UUID
    var name: String
    var calory: Int
    var description: String
    
    
    init(name: String, calory: Int, description: String) {
        self.name = name
        self.calory = calory
        self.description = description
        self.id = UUID()
    }
    
    
}


class EatedDish: Dish {
    var id: UUID
    var name: String
    var calory: Int
    var description: String
    var dateTime: Date
    
    init(name: String, calory: Int, description: String) {
        self.name = name
        self.calory = calory
        self.description = description
        self.id = UUID()
        self .dateTime = Date()
    }
    
    
}
