import UIKit
import EventKit

class TaskTableViewCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    let commentsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        contentView.addSubview(titleLabel)
        
        dateLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(dateLabel)
        
        commentsLabel.font = UIFont.systemFont(ofSize: 14)
        commentsLabel.numberOfLines = 0
        contentView.addSubview(commentsLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        commentsLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            
            commentsLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            commentsLabel.trailingAnchor.constraint(equalTo: dateLabel.trailingAnchor),
            commentsLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            commentsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(task: EKEvent) {
        titleLabel.text = task.title ?? "No Title"
        dateLabel.text = task.startDate.formattedDate()
        commentsLabel.text = task.notes?.replacingOccurrences(of: "CuroAppTask\n", with: "") ?? ""
    }
}
