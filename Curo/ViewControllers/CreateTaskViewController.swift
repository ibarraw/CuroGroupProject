//
//  CreateTaskViewController.swift
//  Curo
//
//  Created by Hajra Rizvi on 2023-04-06.
//

import UIKit
import EventKitUI
import EventKit

class CreateTaskViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIToolbarDelegate {
    
    let eventStore = EKEventStore()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    @IBOutlet weak var courseTextField: UITextField!
    @IBOutlet weak var courseHomepageTextField: UITextField!
    @IBOutlet weak var commentsTextField: UITextField!
    
    let coursePicker = UIPickerView()
    let courses = ["Capstone", "Mobile iOS", "Android", "Advanced .NET"]
    
    let typePicker = UIPickerView()
    let taskTypes = ["Assignment", "Quiz", "Test", "In-class Exercise", "Exam"]
    var selectedButtonIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        coursePicker.delegate = self
        coursePicker.dataSource = self
        coursePicker.backgroundColor = .white
        
        courseTextField.delegate = self
        courseTextField.inputView = coursePicker
        courseTextField.inputAccessoryView = createPickerToolbar()
        
        typePicker.delegate = self
        typePicker.dataSource = self
        typePicker.backgroundColor = .white

        typeTextField.delegate = self
        typeTextField.inputView = typePicker
        typeTextField.inputAccessoryView = createPickerToolbar()
        
        if let selectedIndex = selectedButtonIndex{
            typeTextField.text = taskTypes[selectedIndex]
        }
        
    }
    
    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == coursePicker {
                return courses.count
            } else if pickerView == typePicker {
                return taskTypes.count
            }
            return 0
    }
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == coursePicker {
              return courses[row]
          } else if pickerView == typePicker {
              return taskTypes[row]
          }
          return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == coursePicker {
                courseTextField.text = courses[row]
            } else if pickerView == typePicker {
                typeTextField.text = taskTypes[row]
            }
    }
    
    func createPickerToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.barTintColor = UIColor.systemBlue
        toolbar.isTranslucent = false
        
        let flexibleSpaceLeft = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        doneButton.tintColor = UIColor.white
        let flexibleSpaceRight = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolbar.setItems([flexibleSpaceLeft, doneButton, flexibleSpaceRight], animated: false)
        toolbar.isUserInteractionEnabled = true
        toolbar.delegate = self
        
        return toolbar
    }
    
    @objc func doneButtonTapped() {
        courseTextField.resignFirstResponder()
        typeTextField.resignFirstResponder()
    }
    
    
    
    @IBAction func createTaskButtonTapped(_ sender: Any) {
        // Get user input
        guard let name = nameTextField.text, !name.isEmpty,
              let type = typeTextField.text,
              let course = courseTextField.text, !course.isEmpty,
//              let courseHomepage = courseHomepageTextField.text,
              let comments = commentsTextField.text
        else {
            return
        }
        guard let dueDate = dueDatePicker.date as Date? else {
            return
        }
        
        let courseHomepage = "https://www.sheridancollege.ca/"
        let task = Task(name: name, type: type, dueDate: dueDate, course: course, courseHomepage: courseHomepage, comments: comments)
        
        // Check calendar access
        let status = EKEventStore.authorizationStatus(for: .event)
        switch status {
        case .authorized:
            saveEvent(task: task)
        case .denied, .restricted:
            print("Calendar access denied or restricted")
        case .notDetermined:
            eventStore.requestAccess(to: .event) { [weak self] (granted, error) in
                if granted {
                    self?.saveEvent(task: task)
                } else {
                    print("Calendar access denied")
                }
            }
        @unknown default:
            print("Unknown error")
        }
    }
    
    func saveEvent(task: Task) {
        // Create event
        let event = EKEvent(eventStore: eventStore)
        event.title = task.name
        
        // Combine the fields into one string
        let eventNotes = "\nCuroAppTask Notes:\n\nType: \(task.type)\nCourse: \(task.course)\nCourse Home: \(task.courseHomepage)\nComments: \(task.comments)"
        
        event.notes = eventNotes
        event.startDate = task.dueDate
        event.endDate = task.dueDate
        event.calendar = eventStore.defaultCalendarForNewEvents
        
        // Save event
        do {
            try eventStore.save(event, span: .thisEvent, commit: true)
            let alertController = UIAlertController(title: "Event Saved", message: "Your event has been saved successfully.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] action in
                self?.switchToDashboard() //switch back to the dashboard on successful event save
            }))
            present(alertController, animated: true, completion: nil)
        } catch {
            let alertController = UIAlertController(title: "Error Saving Event", message: "There was an error saving your event. Please try again.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            print("Error saving event: \(error)")
        }
    }
    
    // Dismiss the date picker when a date is selected
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        //model.date = datePicker.date
        self.dismiss(animated: true, completion: nil)
    }
    
    // Switch to tab 1 (DashboardViewController)
    func switchToDashboard() {
        if let tabBarController = self.navigationController?.tabBarController {
            tabBarController.selectedIndex = 0
        }
    }}
