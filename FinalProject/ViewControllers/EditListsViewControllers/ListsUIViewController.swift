import UIKit
import Firebase
import FirebaseDatabase

class ListsUIViewController: UIViewController {
    var groupId = ""
    var listName = ""
    var listArray = [List]()
    var ref: DatabaseReference!
    var isTheFirstTIme = true
    
    @IBOutlet weak var listTable: UITableView!
    @IBOutlet weak var groupNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initViewController()
        readDataFromDB()
    }
    
    func initViewController() {
        ref = Database.database().reference()
        // init table view
        listTable.delegate = self
        listTable.dataSource = self
        listTable.reloadData()
        // put title
        groupNameLabel.text = Constants.Title.listGroupIDTitle + groupId
    }
    
    // read the lists in group from firebase
    func readDataFromDB() {
        self.listArray.removeAll()
        self.listTable.reloadData()
        ref.child("Items group \(groupId)").observeSingleEvent(of: .value, with: {
            snapshot in
            var listNames = [String]()
            for name in snapshot.children {
                listNames.append((name as AnyObject).key)
            }
            for name in listNames {
                let list = List(listName: name)
                self.listArray.append(list)
            }
            self.listTable.reloadData()
        })
    }
    
    @IBAction func addListButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title:Constants.Title.createNewListTitle, message: Constants.Messages.enterNameListMsg, preferredStyle: .alert)
        alert.addTextField {
            (textField) in
            textField.text = ""
        }
        
        alert.addAction(UIAlertAction(title: Constants.Title.okTitle, style: .default, handler: { [weak alert] (_) in
            self.listName = String(Optional(alert?.textFields![0].text! ?? "")!)
            if self.listName != "" {
                self.ref.child("Items group \(self.groupId)").child(self.listName).setValue(self.listName)
                self.readDataFromDB()
            }
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension ListsUIViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        listName = listArray[indexPath.row].listName
    }
}

extension ListsUIViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listArray.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // delete list from firebase
            self.ref.child("Items group \(groupId)").child(self.listArray[indexPath.row].listName).removeValue()
            
            // delete list from table view
            listArray.remove(at: indexPath.row)
            listTable.deleteRows(at: [indexPath], with: .fade)
            
            listTable.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTable.dequeueReusableCell(withIdentifier: ListsTableViewCell.identifier, for: indexPath) as! ListsTableViewCell
        cell.textLabel?.text = listArray[indexPath.row].listName
        cell.title = listArray[indexPath.row].listName
        cell.delegate = self
        cell.accessoryType = .detailDisclosureButton
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Storyboard.editMyListViewController {
            let passGroupId = segue.destination as! ListEditViewController
            passGroupId.groupId = groupId
            let passListName = segue.destination as! ListEditViewController
            passListName.listName = listName
        }
    }
}

extension ListsUIViewController: ListsTableViewCellDelegate {
    func didTapButton(with title: String) {
        listName = title
        self.performSegue(withIdentifier: Constants.Storyboard.editMyListViewController, sender: nil)
        listArray.removeAll()
    }
}
