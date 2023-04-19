//
//  AppDelegate.swift
//  Curo
//
//  Created by John Ho on 2023-04-05.
//

import FirebaseCore
import FirebaseAuth
import SQLite3
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var databaseName : String? = "CuroDatabase.sql"
    var databasePath : String?
    var tasks : [Data] = []

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        // this method creates an array of directories under ~/Documents
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
       
        // ~/Documents is always at index 0
        let documentsDir = documentPaths[0]
        
        // append filename such that path is ~/Documents/MyDatabase.db
        databasePath = documentsDir.appending("/" + databaseName!)
       
        // move onto creating method checkAndCreateDatabase
        checkAndCreateDatabase()
        
        // move on to creating method readDataFromDatabase
        readDataFromDatabase()
        
        return true
    }
    func checkAndCreateDatabase()
    {
            // first step is to see if the file already exists at ~/Documents/MyDatabase.db
            // if it exists, do nothing and return
            var success = false
            let fileManager = FileManager.default
            
            success = fileManager.fileExists(atPath: databasePath!)
        
            if success
            {
                return
            }
        
            // if it doesn't (meaning its a first time load) find location of
            // MyDatabase.db in app file and save the path to it
            let databasePathFromApp = Bundle.main.resourcePath?.appending("/" + databaseName!)
            
        
            // copy file MyDatabase.db from app file into phone at ~/Documents/MyDatabase.db
            try? fileManager.copyItem(atPath: databasePathFromApp!, toPath: databasePath!)
        
        return;
    }
    
    func readDataFromDatabase()
        {
        // now we will retrieve data from database
        // step 7a - empty tasks array
        tasks.removeAll()
        
        // step 7b - define sqlite3 object to interact with db
            var db: OpaquePointer? = nil
            
            // step 7c - open connection to db file - this is C code
            if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
                print("Successfully opened connection to database at \(self.databasePath)")
                
                // step 7d - setup query - entries is the table name you created in step 0
                var queryStatement: OpaquePointer? = nil
                var queryStatementString : String = "select * from entries"
                
                // step 7e - setup object that will handle data transfer
                if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                    
                    // step 7f - loop through row by row to extract dat
                    while( sqlite3_step(queryStatement) == SQLITE_ROW ) {
                    
                        // step 7g - extract columns data, convert from char* to NSString
                        // col 0 - id, col 1 = name, col 2 = email, col 3 = food
                        
                        let id: Int = Int(sqlite3_column_int(queryStatement, 0))
                        let cname = sqlite3_column_text(queryStatement, 1)
                        let ctype = sqlite3_column_text(queryStatement, 2)
                        let cduedate = sqlite3_column_text(queryStatement, 3)
                        let ccourse = sqlite3_column_text(queryStatement, 4)
                        let ccoursehomepage = sqlite3_column_text(queryStatement, 5)
                        let ccomments = sqlite3_column_text(queryStatement, 6)
                        
                        let name = String(cString: cname!)
                        let type = String(cString: ctype!)
                        let duedate = String(cString: cduedate!)
                        let course = String(cString: ccourse!)
                        let coursehomepage = String(cString: ccoursehomepage!)
                        let comments = String(cString: ccomments!)
               
                        // step 7h - save to data object and add to array
                        let data : Data = Data.init()
                        data.initWithData(theRow: id, theName: name, theType: type, theDueDate: duedate, theCourse: course, theCourseHomepage: coursehomepage, theComments: comments)
                        tasks.append(data)
                        
                        print("Query Result:")
                        print("\(id) | \(name) | \(type) | \(duedate) | \(course) | \(coursehomepage) | \(comments)")
                        
                    }
                    // step 7i - clean up
                    
                    sqlite3_finalize(queryStatement)
                } else {
                    print("SELECT statement could not be prepared")
                }
                
                
                // step 7j - close connection
                // move on to ViewController.swift
                sqlite3_close(db);

            }
            else {
                print("Unable to open database.")
            }
        
        }
    
    // step 16 - add method to insert new row into database
    // this method will follow a similar approach to readDataFromDatabase
    // but to insert a new row
    func insertIntoDatabase(task : Data) -> Bool
    {
        // step 16b - define sqlite3 object to interact with db
        var db: OpaquePointer? = nil
        var returnCode : Bool = true
        
        // step 16c - open connection to db file - this is C code
        if sqlite3_open(self.databasePath, &db) == SQLITE_OK {
            print("Successfully opened connection to database at \(self.databasePath)")
            
            // step 16d - setup query - entries is the table name you created in step 0
            var insertStatement: OpaquePointer? = nil
            var insertStatementString : String = "insert into entries values(NULL, ?, ?, ?, ?, ?, ?)"
            
            // step 16e - setup object that will handle data transfer
            if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
               
           
                // step 16f attach items from data object to query
                
                // **Note need to cast as NSString so you can convert to utf8String.  Not doing this will result in fourth column overwriting second and third column
                let nameStr = task.name! as NSString
                let typeStr = task.type! as NSString
                let duedateStr = task.dueDate! as NSString
                let courseStr = task.course! as NSString
                let coursehomepageStr = task.courseHomepage! as NSString
                let commentsStr = task.comments! as NSString
                
                sqlite3_bind_text(insertStatement, 1, nameStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 2, typeStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 3, duedateStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 4, courseStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 5, coursehomepageStr.utf8String, -1, nil)
                sqlite3_bind_text(insertStatement, 6, commentsStr.utf8String, -1, nil)
                
                // step 16g - execute query
                if sqlite3_step(insertStatement) == SQLITE_DONE {
                    let rowID = sqlite3_last_insert_rowid(db)
                    print("Successfully inserted row. \(rowID)")
                } else {
                    print("Could not insert row.")
                    returnCode = false
                }
                // step 16h - clean up
                sqlite3_finalize(insertStatement)
            } else {
                print("INSERT statement could not be prepared.")
                returnCode = false
            }
            
            
            // step 16i - close db connection
            // move on to ViewController.swift
            sqlite3_close(db);
            
        } else {
            print("Unable to open database.")
            returnCode = false
        }
        return returnCode
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

