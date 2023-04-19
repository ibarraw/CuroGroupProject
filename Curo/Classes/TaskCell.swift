//
//  TaskCell.swift
//  Curo
//
//  Created by Hajra Rizvi on 2023-04-18.
//

import UIKit

class TaskCell: UITableViewCell {
    
    
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var lblTaskTitle: UILabel!
    @IBOutlet weak var lblCourse: UILabel!
    @IBOutlet weak var lbldayRemaining: UILabel!
    @IBOutlet weak var lblPriority: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
