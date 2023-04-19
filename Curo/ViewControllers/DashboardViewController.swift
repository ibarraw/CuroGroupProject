//
//  DashboardViewController.swift
//  Curo
//
//  Created by  on 2023-04-06.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var progressView : UIProgressView!
    @IBOutlet var assignBtn : UIButton!
    @IBOutlet var quizbtn : UIButton!
    @IBOutlet var testbtn : UIButton!
    @IBOutlet var exerciseBtn : UIButton!
    @IBOutlet var examBtn : UIButton!
    
    @IBOutlet weak var taskTableView: UITableView!
    
    var listData : Array<String> = []
    
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
        
        var transform : CGAffineTransform = CGAffineTransform(scaleX: 1.2, y: 4.5)
        progressView.transform = transform
        progressView.layer.cornerRadius = 6
        progressView.layer.masksToBounds = true
        
        listData = ["Chapter1", "Chapter2", "Chapter3"]
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // how many cells in the table view
        return listData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = taskTableView.dequeueReusableCell(withIdentifier: "taskCell") as! TaskCell
//        let rowNum = indexPath.row
//        tableCell.textLabel?.text = listData[rowNum]
        
        let rowNum = indexPath.row
        
        tableCell.lblTaskTitle.text = listData[rowNum]
        
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
