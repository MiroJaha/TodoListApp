//
//  ViewController.swift
//  TodoListApp
//
//  Created by admin on 13/12/2021.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    var list = [ToDoList]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let save = (UIApplication.shared.delegate as! AppDelegate).saveContext

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchingAllItems()
    }
    
    //MARK: Fetching (Calling) Data From Database
    func fetchingAllItems() {
        let itemsResult: NSFetchRequest<ToDoList> = ToDoList.fetchRequest()
        do {
            list = try context.fetch(itemsResult)
        }catch {
            print(error)
        }
    }
    
    //MARK: ALL Table View Codes that Needed
    
    //MARK: I Will Need Only 1 Row In Every Section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    //MARK: I Will Use Sections Insted Of Rows So I Can Control Spaces Between Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    //MARK: I Set The Spaces Between Sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    //MARK: To Make The Spaces Visable I Need This Function
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    //MARK: Set Data To Row in Each Section
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListItems", for: indexPath) as! ToDoCustomTableViewCell
        
        return cell
    }
    //MARK: Check ToDoList When Row Selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    //MARK: Slide to Delete From the List
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
}

