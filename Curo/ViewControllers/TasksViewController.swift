//
//  ViewController.swift
//  Curo
//
//  Created by William Ibarra on 2023-04-05.
//
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
        //for appearance
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        // Load tasks from the calendar
        loadTasks()
    }
    
    //get calendar events between 1 year forward, 1 year backward and then filter by events containing notes starting with string "CuroAppTask"
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
    
    //configure cells for each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskTableViewCell
        let task = tasks[indexPath.row]
        cell.configure(task: task)
        return cell
    }


    //If you select a cell, navigate to a webview. Perform this action by accessing the courseHomepage in the notes section
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let task = tasks[indexPath.row]

        // Extract the URL from the notes
        var homepageURL: URL?
        let noteComponents = task.notes!.components(separatedBy: "\n")
        for component in noteComponents {
            if component.hasPrefix("Course Home:") {
                let homepageString = component.replacingOccurrences(of: "Course Home:", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
                homepageURL = URL(string: homepageString)
                break
            }
        }

        // Open the URL in a webview
        if let url = homepageURL {
            let webViewModel = WebViewModel()
            let webViewController = WebViewController(viewModel: webViewModel, homepageURL: url)
            navigationController?.pushViewController(webViewController, animated: true)
        } else {
            print("Error: No URL found in notes")
        }
    }
}

//for animations
extension TasksViewController: EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}

//to change date appearance
extension Date {
    func formattedDate() -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: self)
    }
}
