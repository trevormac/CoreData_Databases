//
//  ViewController.swift
//  Databases
//
//  Created by Trevor MacGregor on 2017-05-25.
//  Copyright © 2017 TeevoCo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //declare constants for the names of our entities
        let studentClassName:String = String(describing: Student.self)
        let courseClassName:String =  String(describing: Course.self)
        
        //inserting this onto our managed object context
        let student:Student = NSEntityDescription.insertNewObject(forEntityName: studentClassName, into: DatabaseController.getContext()) as! Student
        student.firstName = "John"
        student.lastName = "Smith"
        student.age = 22
        
        let course:Course = NSEntityDescription.insertNewObject(forEntityName: courseClassName, into: DatabaseController.getContext()) as! Course
        course.courseName = "Science"
        
        //connect the 2 entities
        student.addToCourses(course)
        
        
        DatabaseController.saveContext()
        
        let fetchRequest:NSFetchRequest<Student> = Student.fetchRequest()
        
        do {
        let searchResults = try DatabaseController.getContext().fetch(fetchRequest)
            print("number of results:\(searchResults.count)")
            
            for result in searchResults as [Student] {
                print("\(result.firstName!) \(result.lastName!) is \(result.age) years old")
            }
        }
        catch {
            print("Error: \(error)")
        }
        DatabaseController.getContext().delete(student)
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

