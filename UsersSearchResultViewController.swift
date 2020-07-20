import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseDatabase

class UsersSearchResultViewController: UIViewController {
    var arrayOfUsersName = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
        func readUsersDetails(){
            let db = Firestore.firestore()
            print("46")
            db.collection("users").getDocuments() { (querySnapshot, err) in
                print("48")
                if let err = err {
                    print("Error getting documents: \(err)")
                    self.arrayOfUsersName = [""]
                } else {
                    for document in querySnapshot!.documents {
                        let userDetails = document.data()
                        for i in userDetails {
                            for j in userDetails {
                                if i.key == "groupId" && i.value as! String == self.groupId && j.key == "firstName"{
                                    self.arrayOfUsersName.append(j.value as! String)
                                }
                            }
                    }
                    }
                    print("HELPER: \( self.arrayOfUsersName)")
            }
        }
    }
    


}
