//
//  ViewController.swift
//  TodoListApp
//
//  Created by admin on 13/12/2021.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {
    
    //Create Array List Variable of the Database
    var list = [ToDoList]()
    
    //Create Needed AppDelegate Variables
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let save = (UIApplication.shared.delegate as! AppDelegate).saveContext

    override func viewDidLoad() {
        super.viewDidLoad()
        //Start by Calling data from Database
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
    
    //MARK: Set the toDoListSaveDelegate delegate to this TableViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! AddToDoTableViewController
        destination.toDoListSaveDelegate = self
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
        //Create the Cell And Design it
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListItems", for: indexPath) as! ToDoCustomTableViewCell
        cell.layer.cornerRadius = 20
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        //Set the data (Title, Note)
        cell.titleLabel.text = list[indexPath.section].title
        cell.noteLabel.text = list[indexPath.section].notes
        //Formating the Date and Set it
        guard let date = list[indexPath.section].dueDate else { return cell }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        cell.dateLabel.text = dateFormatter.string(from: date)
        //Check if Completed or Not to Add Check Mark
        if list[indexPath.section].completion {
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        return cell
    }
    //MARK: Check Mark ToDoList When Row Selected
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = list[indexPath.section]
        //Check if Selected Item Already Selected or Not
        if selectedItem.completion {
            selectedItem.completion = false
        }else {
            selectedItem.completion = true
        }
        //Saving Changes and Fetching the Data Again From Database and Reload the TableView
        save()
        fetchingAllItems()
        tableView.reloadData()
    }
    //MARK: Slide to Delete From the List
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        context.delete(list[indexPath.section])
        //Saving Changes and Fetching the Data Again From Database and Reload the TableView
        save()
        fetchingAllItems()
        tableView.reloadData()
    }
}

//MARK: Extending ToDoListSaveDelegate to Save Entry
extension ToDoListViewController: ToDoListSaveDelegate {
    func saveNewItem(title: String, note: String, date: Date) {
        let newItem = ToDoList(context: context)
        newItem.title = title
        newItem.notes = note
        newItem.dueDate = date
        newItem.completion = false
        //Saving Changes and Fetching the Data Again From Database and Reload the TableView
        save()
        fetchingAllItems()
        tableView.reloadData()
    }
}
