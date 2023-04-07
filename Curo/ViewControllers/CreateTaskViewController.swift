//
//  CreateTaskViewController.swift
//  Curo
//
//  Created by  on 2023-04-06.
//

import UIKit
import EventKitUI
import EventKit

class CreateTaskViewController: UIViewController {

    let eventStore = EKEventStore()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var courseHomepageTextField: UITextField!
    @IBOutlet weak var commentsTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    

    @IBAction func createTaskButtonTapped(_ sender: Any) {
            // Get user input
            guard let name = nameTextField.text,
                  let type = typeTextField.text,
                  let course = courseTextField.text,
                  let courseHomepage = courseHomepageTextField.text,
                  let comments = commentsTextField.text
            else {
                return
            }
            guard let dueDate = dueDatePicker.date as Date? else {
                return
            }

            // Check calendar access
            let status = EKEventStore.authorizationStatus(for: .event)
            switch status {
            case .authorized:
                saveEvent(name: name, type: type, dueDate: dueDate, course: course, courseHomepage: courseHomepage, comments: comments)
            case .denied, .restricted:
                print("Calendar access denied or restricted")
            case .notDetermined:
                eventStore.requestAccess(to: .event) { [weak self] (granted, error) in
                    if granted {
                        self?.saveEvent(name: name, type: type, dueDate: dueDate, course: course, courseHomepage: courseHomepage, comments: comments)
                    } else {
                        print("Calendar access denied")
                    }
                }
            @unknown default:
                print("Unknown error")
            }
        }

        func saveEvent(name: String, type: String, dueDate: Date, course: String, courseHomepage: String, comments: String) {
            // Create event
            let event = EKEvent(eventStore: eventStore)
            event.title = name
            event.notes = comments
            event.startDate = dueDate
            event.endDate = dueDate
            event.calendar = eventStore.defaultCalendarForNewEvents

            // Save event
            do {
                try eventStore.save(event, span: .thisEvent, commit: true)
                print("Event saved successfully")
            } catch {
                print("Error saving event: \(error)")
            }
        }

}
