//
//  StartTimerViewController.swift
//  Curo
//
//  Created by  on 2023-04-06.
//

import UIKit

class StartTimerViewController: UIViewController {

    @IBOutlet weak var roundedCancelButton: UIButton!
    @IBOutlet weak var roundedStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //Round our buttons
        roundedStartButton.layer.cornerRadius = roundedStartButton.frame.width / 2
        roundedStartButton.layer.masksToBounds = true
        
        roundedCancelButton.layer.cornerRadius = roundedCancelButton.frame.width / 2
        roundedCancelButton.layer.masksToBounds = true
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
