//
//  TimerViewController.swift
//  Curo
//
//  Created by  on 2023-04-06.
//

import UIKit
import UserNotifications


class TimerViewController: UIViewController {
    
    @IBOutlet var countdownLabel: UILabel!
    @IBOutlet var pauseButton : UIButton!
    @IBOutlet var cancelButton : UIButton!
    @IBOutlet var taskNameLabel: UILabel!
    
    
    var countdownTime: Date?
    
    var selectedTime: TimeInterval = 0.0
    var isPaused = false
    var intervals: Int = 2 // number of intervals

    var taskName: String?
    
    @IBAction func pausedButtonTapped(sender: UIButton){
        if isPaused{
            //resume the timer
            timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            isPaused = false
            pauseButton.setTitle("Pause", for: .normal)
            
        } else{
            //pause the timer
            timer.invalidate()
            isPaused = true
            pauseButton.setTitle("Resume", for: .normal)
        }
    }
    
    
    
    
    
    let timeLeftShapeLayer = CAShapeLayer()
    let bgShapeLayer = CAShapeLayer()
    var timeLeft: TimeInterval = 60
    var endTime: Date?
    var timeLabel =  UILabel()
    var timer = Timer()
    // here you create your basic animation object to animate the strokeEnd
    let strokeIt = CABasicAnimation(keyPath: "strokeEnd")
    func drawBgShape() {
        bgShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX , y: view.frame.midY - 130), radius:
            120, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        bgShapeLayer.strokeColor = UIColor.white.cgColor
        bgShapeLayer.fillColor = UIColor.clear.cgColor
        bgShapeLayer.lineWidth = 15
        view.layer.addSublayer(bgShapeLayer)
    }
    func drawTimeLeftShape() {
        timeLeftShapeLayer.path = UIBezierPath(arcCenter: CGPoint(x: view.frame.midX , y: view.frame.midY - 130), radius:
            120, startAngle: -90.degreesToRadians, endAngle: 270.degreesToRadians, clockwise: true).cgPath
        timeLeftShapeLayer.strokeColor = UIColor.yellow.cgColor
        timeLeftShapeLayer.fillColor = UIColor.clear.cgColor
        timeLeftShapeLayer.lineWidth = 15
        view.layer.addSublayer(timeLeftShapeLayer)
    }
    func addTimeLabel() {
        timeLabel = UILabel(frame: CGRect(x: view.frame.midX-50 ,y: view.frame.midY - 100, width: 100, height: 50))
        timeLabel.textAlignment = .center
        timeLabel.text = formattedTimeString(timeInterval: selectedTime)
        timeLabel.font = timeLabel.font.withSize(30)
        view.addSubview(timeLabel)
    }
    

    
    private func formattedTimeString(timeInterval: TimeInterval) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter.string(from: timeInterval)!
    }
    
    

    func sendPushNotification(){
        let content = UNMutableNotificationContent()
        content.title = "Timer Complete"
        content.body = "Your timer has finished"
        content.sound = UNNotificationSound.default
    }
    
    
    func checkForPermission(){
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings{ settings in
            switch settings.authorizationStatus{
            case .authorized:
                self.dispatchNotification()
            case .denied:
                return
            case .notDetermined:
                notificationCenter.requestAuthorization(options: [.alert, .sound]) { didAllow, error in
                    if didAllow {
                        self.dispatchNotification()
                    }
                }
            default:
                return
            }
        }
    }
    
    func dispatchNotification(){
        let identifier = "Timer Notification"
        let title = "Time is Up!"
        let body = "Your time is up!"
        let hour = 12
        let minute = 15
        let isDaily = true
        
        let notificationCenter = UNUserNotificationCenter.current()
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        
        let calendar = Calendar.current
        var dateComponents = DateComponents(calendar: calendar, timeZone: TimeZone.current)
        dateComponents.hour = hour
        dateComponents.minute = minute
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: isDaily)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForPermission()
        
//        let timeInterval = countdownTime?.timeIntervalSinceNow
//        if timeInterval! > 0.0 {
//            selectedTime = timeInterval!
//            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//                self.selectedTime -= 1.0
//                if self.selectedTime <= 0 {
//                    timer.invalidate()
//                }
//            }
//        }
//        countdownLabel.text = formattedTimeString(timeInterval: selectedTime)
        taskNameLabel.text = taskName
    
        view.backgroundColor = UIColor(white: 0.94, alpha: 1.0)
        drawBgShape()
        drawTimeLeftShape()
        addTimeLabel()
        // here you define the fromValue, toValue and duration of your animation
        strokeIt.fromValue = 0
        strokeIt.toValue = 1
        strokeIt.duration = 60
        // add the animation to your timeLeftShapeLayer
        timeLeftShapeLayer.add(strokeIt, forKey: nil)
        // define the future end time by adding the timeLeft to now Date()
        endTime = Date().addingTimeInterval(selectedTime)
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        
        
        }
    
    @objc func updateTime() {
    if timeLeft > 0 {
        timeLeft = endTime?.timeIntervalSinceNow ?? 0
        timeLabel.text = timeLeft.time
        timeLeftShapeLayer.strokeEnd = CGFloat(timeLeft / selectedTime)
        } else {
        timeLabel.text = "00:00"
        timer.invalidate()
            sendPushNotification()
        }
    }
}
extension TimeInterval {
    var time: String {
        return String(format:"%02d:%02d", Int(self/60),  Int(floor(truncatingRemainder(dividingBy: 60))) )
    }
}
extension Int {
    var degreesToRadians : CGFloat {
        return CGFloat(self) * .pi / 180
    }


        // Do any additional setup after loading the view.
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

