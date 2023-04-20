//
//  StartTimerViewController.swift
//  Curo
//
//  Created by Hajra Rizvi on 2023-04-06.
//

import UIKit

class StartTimerViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var roundedCancelButton: UIButton!
    @IBOutlet var roundedStartButton: UIButton!
    
    @IBOutlet var timePicker: UIDatePicker!
    
    @IBOutlet var tfTaskName: UITextField!
    
    var selectedTime: TimeInterval = 0.0
    
    
    // when start button is pressed send the selectedTime to TimerViewController
    @IBAction func buttonPressed(sender: Any){
        selectedTime = timePicker.countDownDuration
        performSegue(withIdentifier: "goTimerViewController", sender: self)
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?){
        if segue.identifier == "goTimerViewController" {
            if let timeViewController = segue.destination as? TimerViewController {
                timeViewController.selectedTime = selectedTime
                timeViewController.taskName = tfTaskName.text
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
 
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
