import UIKit
import Firebase
import FirebaseDatabase

class ListEditViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var ref: DatabaseReference!
    var groupId: String = ""
    var listName: String = ""
    var itemsList = [Item]()
    
    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemQuantityTextField: UITextField!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var listNameLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        
        ref = Database.database().reference().child("Items group \(groupId)").child(listName).child("items")
        initTable()
        observeReference()
        
        listNameLabel.text = Constants.Title.nameListTitle + listName
        
    }
    
    func initTable() {
        errorLabel.alpha = 0
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.reloadData()
    }
    
    func observeReference() {
        ref.observe(DataEventType.value, with: {(SnapshotMetadata) in
            if SnapshotMetadata.childrenCount > 0 {
                self.itemsList.removeAll()
                
                for item in SnapshotMetadata.children.allObjects as! [DataSnapshot] {
                    let itemObject = item.value as? [String: AnyObject]
                    let itemName = itemObject?[Constants.Database.itemName]
                    let itemId = itemObject?[Constants.Database.itemId]
                    let itemQuantity = itemObject?[Constants.Database.itemQuantity]
                    
                    let item = Item(itemName: itemName as! String, itemID: itemId as! String, itemQuantity: itemQuantity as! String)
                    self.itemsList.append(item)
                }
                self.listTableView.reloadData()
            }
        })
    }
    
    @IBAction func stepperPressed(sender: UIStepper) {
        self.itemQuantityTextField.text = Int(sender.value).description
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = deleleAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func deleleAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: Constants.Data.delete) { (action, view, completion) in
            
            //delete item from firebase
            self.ref.child(self.itemsList[indexPath.row].itemID).removeValue()
            
            //delete item from tableView
            self.itemsList.remove(at: indexPath.row)
            self.listTableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        action.image = #imageLiteral(resourceName: "Trash")
        action.backgroundColor = .red
        
        return action
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Storyboard.tableViewCell, for: indexPath) as! TableViewCell
        let item : Item
        item = itemsList[indexPath.row]
        
        cell.nameLabel.text = item.itemName
        cell.quantityLabel.text = item.itemQuantity
        
        return cell
    }
    
    @IBAction func addItemButtonPresses(_ sender: Any) {
        if itemQuantityTextField.text != "" && itemNameTextField.text != "" {
            addItemToList()
            resetValues()
        } else {
            errorLabel.text = Constants.Messages.fillAllFieldsMsg
            errorLabel.alpha = 1
        }
    }
    
    func resetValues() {
        itemNameTextField.text = ""
        itemQuantityTextField.text = ""
        stepper.value = 0
        errorLabel.alpha = 0
    }
    
    //write item to firebase
    func addItemToList() {
        let key = ref.childByAutoId().key
        let item = [Constants.Database.itemId: key, Constants.Database.itemName: itemNameTextField.text! as String, Constants.Database.itemQuantity: itemQuantityTextField.text! as String]
        ref.child(key!).setValue(item)
    }
    
}


