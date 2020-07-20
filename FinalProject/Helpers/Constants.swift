import Foundation

struct Constants {
    
    struct Media {
        static let mediaName = "videoTODO"
        static let mediaType = "mp4"
    }
    
    struct Storyboard {
        static let homeViewController = "HomePage"
        static let listsUiViewController = "myLists"
        static let groupMembersViewController = "showGroupMembers"
        static let cellTableView = "Cell"
        static let tableViewCell = "tableViewCell"
        static let editMyListViewController = "editMyList"
    }
    
    struct Database {
        static let usersFirebase = "users"
        static let firstNameFirebase = "firstName"
        static let lastNameFirebase = "lastName"
        static let emailFirebase = "email"
        static let uidFirebase = "uid"
        static let itemName = "itemName"
        static let itemId = "itemId"
        static let itemQuantity = "itemQuantity"
    }
    
    struct Data {
        static let groupIdStr = "groupId"
        static let delete = "Delete"
    }
    
    struct Messages {
        static let fillAllMsg = "Please fill all the fields."
        static let groupIdDidntExistMsg = "Group id number didn't exist."
        static let errorCreateUserMsg = "Error creating user! "
        static let errorSavingUser = "Error saving user"
        static let errorGetDoc = "Error getting documents"
        static let fillAllFieldsMsg = "Please fill all the fields"
        static let enterNameListMsg =  "Enter list name: "
    }
    
    struct Title {
        static let nameListTitle = "TODO Shopping List: "
        static let listGroupIDTitle = "Lists of group: "
        static let createNewListTitle = "Create a new list "
        static let okTitle = "OK"
    }
    
}

