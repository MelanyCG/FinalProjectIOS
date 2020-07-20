import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseDatabase

class LoginViewController: UIViewController {
    var groupId: String = ""
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        setUpElements()
    }
    
    func setUpElements() {
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    
    @IBAction func loginClicked (_sender: Any){
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.errorLabel.text = error?.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                let db = Firestore.firestore()
                db.collection(Constants.Database.usersFirebase).getDocuments() { (querySnapshot, err) in
                    if err != nil {
                        print(Constants.Messages.errorGetDoc)
                    } else {
                        for document in querySnapshot!.documents {
                            let array = document.data()
                            for i in array {
                                for j in array {
                                    if i.key == Constants.Data.groupIdStr && j.1 as! String == email{
                                        self.groupId = i.value as! String
                                    }
                                }
                            }
                        }
                    }
                    self.performSegue(withIdentifier: Constants.Storyboard.homeViewController, sender: nil)
                    self.clearFields()
                }
            }
        }
    }
    
    func clearFields() {
        emailTextField.text = ""
        passwordTextField.text = ""
        errorLabel.text = ""
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == Constants.Storyboard.homeViewController){
            let passGroupId = segue.destination as! HomeViewController
            passGroupId.groupId = groupId
        }
    }
    
    
}
