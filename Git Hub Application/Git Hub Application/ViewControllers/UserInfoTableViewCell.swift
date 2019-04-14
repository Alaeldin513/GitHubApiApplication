//
//  SimpleLabelCell.swift
//  Git Hub Application
//
//  Created by Mobile on 4/12/19.
//  Copyright © 2019 Mobile. All rights reserved.
//

import UIKit

class SimpleLabelCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func cofigure(cellTitle: String, cellValue: String){
        self.cellTitle.text = cellTitle
        self.cellValue.text = cellValue != "nil" ? cellValue:"0"
    }
}
