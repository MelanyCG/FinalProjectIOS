import Foundation

class Item {
    
    var itemName = ""
    var itemQuantity = ""
    var itemID = ""
    
    init(){}
    
    init(itemName: String , itemID: String, itemQuantity: String){
        self.itemName = itemName
        self.itemID = itemID
        self.itemQuantity = itemQuantity
    }
}
