import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseDatabase
import SwiftUI

class SingUpViewController: UIViewController {
    var groupId: String = ""
    var groupIdButtonPressed = false
    var groupsArray = Set<String>()
    var ref: DatabaseReference!
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var secondNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var groupIdTextField: UITextField!
    @IBOutlet weak var singUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var groupIdButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        
        setUpElements()
        readGroupsFromDB()
        ref = Database.database().reference()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(secondNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleTextField(groupIdTextField)
        Utilities.styleFilledButton(singUpButton)
    }
    
    // read groups id from database and insert into array
    func readGroupsFromDB(){
        let db = Firestore.firestore()
        db.collection(Constants.Database.usersFirebase).getDocuments() { (querySnapshot, err) in
            for document in querySnapshot!.documents {
                let userDetails = document.data()
                for i in userDetails {
                    if i.key == Constants.Data.groupIdStr {
                        self.groupsArray.insert(i.value as! String)
                    }
                }
            }
        }
    }
    
    // Check the fields and validate that the data is correct
    func validateFields() -> String? {
        // check fields are not empty
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || secondNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || groupIdTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return Constants.Messages.fillAllMsg
        }
        
        // check if the group id that user write exist
        if !groupsArray.contains(groupIdTextField.text!) && groupIdButtonPressed == false {
            return Constants.Messages.groupIdDidntExistMsg
        }
        
        return nil
    }
    
    @IBAction func singUpButtonPressed(_sender: Any){
        let error = validateFields()
        if error != nil {
            showError(error!)
            clearFields()
        }
        else {
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let secondName = secondNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            groupId = groupIdTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                let db = Firestore.firestore()
                db.collection(Constants.Database.usersFirebase).addDocument(data: [Constants.Database.firstNameFirebase: firstName, Constants.Database.lastNameFirebase: secondName, Constants.Data.groupIdStr: self.groupId, Constants.Database.emailFirebase: email, Constants.Database.uidFirebase: result!.user.uid]) { (error) in
                    if error != nil {
                        self.showError(Constants.Messages.errorSavingUser)
                        self.clearFields()
                    }
                }
                self.transitionToHomeScreen()
            }
        }
    }
    
    func clearFields() {
        firstNameTextField.text = ""
        secondNameTextField.text = ""
        emailTextField.text = ""
        groupIdTextField.text = ""
        passwordTextField.text = ""
    }
    
    
    @IBAction func getNewIdPressed(_ sender: Any) {
        groupIdButtonPressed = true
        
        // Create a random group id
        var randomId = String(Int.random(in: 1..<10000))
        
        // Check if the created group id didnt exist yet
        let db = Firestore.firestore()
        db.collection(Constants.Database.usersFirebase).getDocuments() { (querySnapshot, err) in
            if err != nil {
                print(Constants.Messages.errorGetDoc)
            } else {
                for document in querySnapshot!.documents {
                    let array = document.data()
                    let filtered = array.filter { y in
                        return y.key == Constants.Data.groupIdStr
                    }
                    for i in filtered.values {
                        if i as! String == randomId {
                            randomId = String(Int.random(in: 1..<10000))
                        }
                        else {
                            self.groupIdTextField.text = randomId
                        }
                    }
                }
            }
        }
        groupId = randomId
    }
    
    
    func showError(_ message: String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToHomeScreen() {
        self.performSegue(withIdentifier: Constants.Storyboard.homeViewController , sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.Storyboard.homeViewController){
            let passGroupId = segue.destination as! HomeViewController
            passGroupId.groupId = groupId
        }
    }
}


extension Array where Element: Equatable {
    func all(where predicate: (Element) -> Bool) -> [Element]  {
        return self.compactMap { predicate($0) ? $0 : nil }
    }
}
