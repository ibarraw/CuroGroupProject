//
//  DashboardViewController.swift
//  Curo
//
//  Created by  on 2023-04-06.
//

import UIKit

class DashboardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var progressView : UIProgressView!
    
    var listData : Array<String> = []
    
    

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
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell()
        let rowNum = indexPath.row
        tableCell.textLabel?.text = listData[rowNum]
        
        tableCell.textLabel?.font = UIFont.systemFont(ofSize: 50, weight: .bold)
        tableCell.accessoryType = .disclosureIndicator
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
