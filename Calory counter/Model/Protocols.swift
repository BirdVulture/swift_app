import Foundation

protocol  Dish {
    var id: UUID {get}
    var name: String {get}
    var calory: Int {get}
}


protocol MenuDishDelegate: AnyObject {
    func addDish(_ controller: AddDish, didCreate dish: Dish)
    func deleteDish(_ controller: EditDish, deleteRowAt index: Int)
    func updateDish(_ controller: EditDish, updateRowAt index: Int, didUpdate dish: any Dish)
}

protocol EatedDishDelegate: AnyObject {
    func eatDish(_ controller: EatDish, didCreate dish: Dish)
    func deleteEatedDish(_ controller: EditEatedDish, deleteRowAt index: Int)
    func updateEatedDish(_ controller: EditEatedDish, updateRowAt index: Int, didUpdate dish: any Dish)
}
