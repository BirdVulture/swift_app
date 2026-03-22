//
//  EatedDish.swift
//  Calory counter
//
//  Created by Oleg Z on 22.03.2026.
//
import Foundation


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
