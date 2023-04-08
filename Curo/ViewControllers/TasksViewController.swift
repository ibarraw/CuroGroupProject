import UIKit
import EventKitUI
import EventKit

class TasksViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let eventStore = EKEventStore()
    var tasks: [EKEvent] = []
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        
        let backgroundImage = UIImage(named: "CreateTaskBackground")
        let imageView = UIImageView(image: backgroundImage)
        tableView.backgroundView = imageView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TaskTableViewCell.self, forCellReuseIdentifier: "taskCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Load tasks from the calendar
        loadTasks()
    }
    
    func loadTasks() {
        let calendars = eventStore.calendars(for: .event)
        let oneYearAgo = Date().addingTimeInterval(-365*24*60*60)
        let oneYearLater = Date().addingTimeInterval(365*24*60*60)
        
        let predicate = eventStore.predicateForEvents(withStart: oneYearAgo, end: oneYearLater, calendars: calendars)
        let allEvents = eventStore.events(matching: predicate)
        
        // Filter tasks added by the app
        tasks = allEvents.filter { $0.notes?.contains("CuroAppTask") == true }
        
        tableView.reloadData()
    }

    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]
        cell.configure(task: task)
        return cell
    }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let task = tasks[indexPath.row]
        
        // Open the event in the Calendar app at the start date
        let interval = task.startDate.timeIntervalSinceReferenceDate
        if let url = URL(string: "calshow:\(interval)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            print("Error creating URL")
        }
    }

}

extension TasksViewController: EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}

extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
