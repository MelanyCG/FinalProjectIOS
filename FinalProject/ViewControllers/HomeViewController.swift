import UIKit
import Firebase
import FirebaseDatabase
import SwiftUI

class HomeViewController: UIViewController {
    var groupId: String = ""
    var ref: DatabaseReference!
    
    @IBOutlet weak var editListsButton: UIButton!
    @IBOutlet weak var groupMembersButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: false)
        
        setUpElements()
        ref = Database.database().reference()
        
    }
    
    func setUpElements() {
        Utilities.styleHollowButton(editListsButton)
        Utilities.styleHollowButton(groupMembersButton)
    }
    
    @IBAction func editMyLists(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.Storyboard.listsUiViewController, sender: nil)
    }
    
    @IBAction func showGroupMembers(_ sender: Any) {
        self.performSegue(withIdentifier: Constants.Storyboard.groupMembersViewController, sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Storyboard.groupMembersViewController {
            let passGroupId = segue.destination as! CollectionViewController
            passGroupId.groupId = groupId
        }
        
        if segue.identifier == Constants.Storyboard.listsUiViewController {
            let passGroupId = segue.destination as! ListsUIViewController
            passGroupId.groupId = groupId
        }
    }
    
    
}

