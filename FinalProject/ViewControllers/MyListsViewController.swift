//
//
//import UIKit
//import Firebase
//import FirebaseDatabase
//
//class MyListsViewController: UIViewController{
//    
//    var ref: DatabaseReference!
//    var groupId: String = ""
//    var listsArray = [List]()
//    var listName = ""
//
//    @IBOutlet weak var listsTableView: UITableView!
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//                    
//            ref = Database.database().reference().child("Items group \(groupId)")
//            initTable()
//
//        }
//        
//        func initTable() {
//            listsTableView.delegate = self
//            listsTableView.dataSource = self
//        }
//
//    
//    @IBAction func editButtonPress(_ sender: Any) {
//        
//        
//    }
//    
//
//    @IBAction func addAnewListButtonPress(_ sender: Any) {
//            let alert = UIAlertController(title: "Create a new list ", message: "Enter list name: ", preferredStyle: .alert)
//            alert.addTextField {
//                (textField) in
//                textField.text = ""
//            }
//        
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
//                self.listName = String(Optional(alert?.textFields![0].text! ?? "")!)
//                self.ref.child("Items group \(self.groupId)").child(self.listName).setValue(["listName": self.listName])
//                }))
//
//            self.present(alert, animated: true, completion: nil)
//    
//}
//    
//    
//
//    
//
//
//
////
////
////var ref: DatabaseReference!
////var groupId: String = ""
////var listName: String = ""
////var itemsList = [Item]()
////
////@IBOutlet weak var itemNameTextField: UITextField!
////@IBOutlet weak var itemQuantityTextField: UITextField!
////@IBOutlet weak var listTableView: UITableView!
////@IBOutlet weak var listNameLabel: UILabel!
////
////
////override func viewDidLoad() {
////    super.viewDidLoad()
////
////    ref = Database.database().reference().child("Items group \(groupId)")
////    initTable()
////    observeReference()
////
////}
////
////func initTable() {
////    listTableView.delegate = self
////    listTableView.dataSource = self
////    listTableView.reloadData()
////}
////
////func observeReference() {
////    ref.observe(DataEventType.value, with: {(SnapshotMetadata) in
////        if SnapshotMetadata.childrenCount > 0 {
////            self.itemsList.removeAll()
////
////            for item in SnapshotMetadata.children.allObjects as! [DataSnapshot] {
////                let itemObject = item.value as? [String: AnyObject]
////                let itemName = itemObject?["itemName"]
////                let itemId = itemObject?["itemId"]
////                let itemQuantity = itemObject?["itemQuantity"]
////
////                let item = Item(itemName: itemName as! String, itemID: itemId as! String, itemQuantity: itemQuantity as! String)
////                self.itemsList.append(item)
////            }
////            self.listTableView.reloadData()
////        }
////    })
////}
//
////
////func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////    return itemsList.count
////}
////
////func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////    let cell = tableView.dequeueReusableCell(withIdentifier: "listTableViewCell", for: indexPath) as! TableViewCell
////    let item : Item
////    item = itemsList[indexPath.row]
////
////    cell.nameLabel.text = item.itemName
////    cell.quantityLabel.text = item.itemQuantity
////
////    return cell
////}
////
////@IBAction func addItemButtonPresses(_ sender: Any) {
////    addItemToList()
////    itemNameTextField.text = ""
////    itemQuantityTextField.text = ""
////}
////
////func addItemToList() {
////    //wrute item to firebase
////    let key = ref.childByAutoId().key
////    let item = ["itemId": key, "itemName": itemNameTextField.text! as String, "itemQuantity": itemQuantityTextField.text! as String]
////    ref.child(key!).setValue(item)
//
//}
