import Foundation
import UIKit

class Task {
    var name: String
    var type: String
    var dueDate: Date
    var course: String
    var courseHomepage: String
    var comments: String

    init(name: String, type: String, dueDate: Date, course: String, courseHomepage: String, comments: String) {
        self.name = name
        self.type = type
        self.dueDate = dueDate
        self.course = course
        self.courseHomepage = courseHomepage
        self.comments = comments
    }
    
    init(name: String, course: String, dueDate: Date) {
        self.name = name
        self.course = course
        self.dueDate = dueDate
        self.type = ""
        self.courseHomepage = ""
        self.comments = ""
        
    }
}
