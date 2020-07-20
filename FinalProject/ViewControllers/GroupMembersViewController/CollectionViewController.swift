import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseDatabase

class CollectionViewController: UICollectionViewController {
    var arrayOfUsersName = [String]()
    var groupId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readUsersDetails()
        initCollectionView()
        
    }
    
    func initCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfUsersName.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        if let usersCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Storyboard.cellTableView, for: indexPath) as? CollectionViewCell {
            usersCell.configure(with: arrayOfUsersName[indexPath.row])
            cell = usersCell
        }
        cell.backgroundColor = .systemBlue
        
        return cell
    }
    
    func readUsersDetails(){
        let db = Firestore.firestore()
        db.collection(Constants.Database.usersFirebase).getDocuments() { (querySnapshot, err) in
            self.collectionView.reloadData()
            if err != nil {
                print(Constants.Messages.errorGetDoc)
                self.arrayOfUsersName = [""]
            } else {
                for document in querySnapshot!.documents {
                    let userDetails = document.data()
                    for i in userDetails {
                        for j in userDetails {
                            if i.key == Constants.Data.groupIdStr && i.value as! String == self.groupId && j.key == Constants.Database.firstNameFirebase {
                                self.arrayOfUsersName.append(j.value as! String)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let totalCellWidth = Int(collectionView.layer.frame.size.width) / 3 * collectionView.numberOfItems(inSection: 0)
        let totalSpacingWidth = (collectionView.numberOfItems(inSection: 0) - 1)
        
        let leftInset = (collectionView.layer.frame.size.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        let rightInset = leftInset
        
        return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
    }
    
    
    
}
