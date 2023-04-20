//
//  TimerData.swift
//  Curo
//
//  Created by Hajra Rizvi on 2023-04-19.
//

import Foundation

class TimerData{
    
    var selectTime : TimeInterval
    var task: String
    
    init(selectTime : TimeInterval, task: String) {
        self.selectTime = selectTime
        self.task = task
    }

}
