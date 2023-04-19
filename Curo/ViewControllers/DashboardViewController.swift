//
//  DashboardViewController.swift
//  Curo
//
//  Created by  on 2023-04-06.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var lblToday : UILabel!
    @IBOutlet var lblName : UILabel!
    
    @IBOutlet var progressView : UIProgressView!
    @IBOutlet var assignBtn : UIButton!
    @IBOutlet var quizbtn : UIButton!
    @IBOutlet var testbtn : UIButton!
    @IBOutlet var exerciseBtn : UIButton!
    @IBOutlet var examBtn : UIButton!
    @IBOutlet var lblTasktoComplete : UILabel!
    @IBOutlet var lblNumTasks : UILabel!
    
    
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var listData : Array<String> = []
    var firstName: String?
    let mainDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBAction func assignButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "createTaskSegue", sender: 0)
    }

    @IBAction func quizButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "createTaskSegue", sender: 1)
    }
    
    @IBAction func testButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "createTaskSegue", sender: 2)
    }

    @IBAction func exerciseButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "createTaskSegue", sender: 3)
    }

    @IBAction func examButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "createTaskSegue", sender: 4)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "createTaskSegue" {
            let selectedIndex = sender as? Int ?? 0
            if let createTaskVC = segue.destination as? CreateTaskViewController {
                createTaskVC.selectedButtonIndex = selectedIndex
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        lblName.text = firstName
        
        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.2, y: 4.5)
        progressView.transform = transform
        progressView.layer.cornerRadius = 6
        progressView.layer.masksToBounds = true
        
        listData = ["Chapter1", "Chapter2", "Chapter3"]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd"
        let today = Date()
        let formattedDate = dateFormatter.string(from: today)
        lblToday.text = formattedDate
        
        // Format Table Cell View
        taskTableView.separatorStyle = .none
        // Do any additional setup after loading the view.
        lblTasktoComplete.text = "You have completed 0% of your tasks today!"
        
        lblNumTasks.text = "You have \(String(mainDelegate.tasks.count)) tasks"
        
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // how many cells in the table view
        return mainDelegate.tasks.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = taskTableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskCell

       
        let rowNum = indexPath.row
        
//        tableCell.lblTaskTitle.text = listData[rowNum]
        tableCell.lblTaskTitle.text = mainDelegate.tasks[rowNum].name
        tableCell.lblCourse.text = "Course: " + mainDelegate.tasks[rowNum].course!
        
        // Get days left
        let daysLeft = mainDelegate.tasks[rowNum].dueDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        let date = dateFormatter.date(from: daysLeft!)
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: Date(), to: date!)

        let daysRemaining = components.day ?? 0
        
        
        if daysRemaining < 1 {
            tableCell.lblPriority.text = "Priority: High"
            tableCell.lbldayRemaining.text = "Overdue"
        } else if daysRemaining > 2 && daysRemaining < 3 {
            tableCell.lblPriority.text = "Priority: Medium"
            tableCell.lbldayRemaining.text = String(daysRemaining) + " left"
        }else{
            tableCell.lblPriority.text = "Priority: Low"
            tableCell.lbldayRemaining.text = String(daysRemaining) + " left"
        }
        
        tableCell.taskView.layer.cornerRadius = tableCell.taskView.frame.height / 4
        
        return tableCell
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
