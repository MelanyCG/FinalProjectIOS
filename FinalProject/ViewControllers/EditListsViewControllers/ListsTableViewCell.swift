//
//  ListsTableViewCell.swift
//  FinalProject
//
//  Created by user167402 on 7/13/20.
//  Copyright © 2020 user167402. All rights reserved.
//

import UIKit

protocol ListsTableViewCellDelegate: AnyObject {
    func didTapButton(with title: String)
}

class ListsTableViewCell: UITableViewCell {
    
    weak var delegate: ListsTableViewCellDelegate?
    
    static let identifier = "cellList"
    
    @IBOutlet weak var seeListButton: UIButton!
    public var title: String = ""
    
    @IBAction func didTapButton() {
        delegate?.didTapButton(with: title)
    }
    
    
}
