//
//  Data.swift
//  Curo
//
//  Created by John Ho on 2023-04-19.
//

import UIKit

//data object
class Data: NSObject {
    var id : Int?
    var name : String?
    var type : String?
    var dueDate : String?
    var course : String?
    var courseHomepage : String?
    var comments : String?
    
    func initWithData(theRow i:Int, theName n:String, theType t:String, theDueDate d:String, theCourse c:String, theCourseHomepage cH:String, theComments cm:String)
    {
        id = i
        name = n
        type = t
        dueDate = d
        course = c
        courseHomepage = cH
        comments = cm
    }
}
