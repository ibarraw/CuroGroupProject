//
//  TaskCell.swift
//  Curo
//
//  Created by  on 2023-04-18.
//

import UIKit

class TaskCell: UITableViewCell {
    
    
    @IBOutlet weak var taskView: UIView!
    @IBOutlet weak var lblTaskTitle: UILabel!
    @IBOutlet weak var lblCourse: UILabel!
    @IBOutlet weak var lbldayRemaining: UILabel!
    @IBOutlet weak var lblPriority: UILabel!
    
    let primaryLabel = UILabel()
    let secondaryLabel = UILabel()
    let thirdLabel = UILabel()
    
    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        primaryLabel.textAlignment = .left
//        primaryLabel.font = UIFont.systemFont(ofSize: 30)
//        primaryLabel.backgroundColor = .clear
//        primaryLabel.textColor = .black
//
//        secondaryLabel.textAlignment = .left
//        secondaryLabel.font = UIFont.systemFont(ofSize: 18)
//        secondaryLabel.backgroundColor = .clear
//        secondaryLabel.textColor = .black
//
//
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
