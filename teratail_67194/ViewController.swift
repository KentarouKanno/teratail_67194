//
//  ViewController.swift
//  teratail_67194
//
//  Created by Kentarou on 2017/02/26.
//  Copyright © 2017年 Kentarou. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tableView: UITableView!
    
    var people = [Person]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "\"The List\""
    }
    
    func tableView(_ tableVeiw: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let person = people[indexPath.row]
        cell.textLabel?.text = person.name
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US") as Locale! // ロケールの設定
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH:mm"//:ss" // 日付フォーマットの設定
        
        let dateString = dateFormatter.string(from: person.time)
        cell.detailTextLabel!.text = dateString
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            context.delete(people[indexPath.row])
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            fetchRequest()
        }
    }
    
    @IBAction func addName(_ sender: UIButton) {
        let alert = UIAlertController(title: "New name", message: "Enter a new name", preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { (action) in
            
            let textField = alert.textFields?.first
            self.saveName(name: textField!.text!)
            self.tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField(configurationHandler: nil)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated:  true, completion: nil)
    }
    
    func saveName(name: String){
        let person = Person(entity: Person.entity(), insertInto: context)
        person.name = name
        person.time = Date()
        
        do{
            try context.save()
            people.insert(person, at: 0)
        } catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRequest()
    }
    
    func fetchRequest() {
        
        do{
            let fetchRequest = Person.fetchRequest()
            let sortDescripter = NSSortDescriptor(key: "time", ascending: false)
            fetchRequest.sortDescriptors = [sortDescripter]
            
            let result = try context.fetch(fetchRequest)
            people = result as! [Person]
        }catch let error as NSError {
            print("Could not save \(error), \(error.userInfo)")
        }
        tableView.reloadData()
    }
}
