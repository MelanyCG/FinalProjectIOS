import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    func configure(with userName: String) {
        userNameLabel.text = userName
    }
    
}
