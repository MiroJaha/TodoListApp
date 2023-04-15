//
//  AddToDoTableViewController.swift
//  TodoListApp
//
//  Created by admin on 13/12/2021.
//

import UIKit

class AddToDoTableViewController: UITableViewController {
   
    //Connect My IBOutlet
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //Create ToDoListSaveDelegate Variable To Pass The Data
    weak var toDoListSaveDelegate: ToDoListSaveDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: Set Placeholder To The Note TextView
        noteTextView.delegate = self
        noteTextView.text = "Please Enter Note Here"
        noteTextView.textColor = .lightGray
        //MARK: Designing TextField and TextView
        noteTextView.layer.cornerRadius = 10
        titleTextField.layer.cornerRadius = 20
        titleTextField.layer.borderWidth = 2
        titleTextField.layer.masksToBounds = true
        titleTextField.layer.borderColor = UIColor.red.cgColor
        //MARK: Allow Only Future Dates to be Set
        datePicker.minimumDate = .now
    }
    
    //MARK: Save New Item
    @IBAction func addItemButton(_ sender: UIButton) {
        if checkEntry() {
            guard let title = titleTextField.text else { return }
            guard let note = noteTextView.text else { return }
            let date = datePicker.date
            toDoListSaveDelegate?.saveNewItem(title: title, note: note, date: date)
            //Back To Main View
            self.navigationController?.popViewController(animated: true)
        }else {
            let alert = UIAlertController(title: "WARNING", message: "Please Enter Valid Values", preferredStyle: .alert)
            alert.view.backgroundColor = .red
            alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: {action in
                return
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    //MARK: Function to Check All Entries
    func checkEntry() -> Bool {
        var check = true
        if let title = titleTextField.text {
            if title.isEmpty {
                check = false
            }
        }
        if noteTextView.textColor == .lightGray {
            check = false
        }
        return check
    }
    
    //MARK: Using This Function To Add Corners To The Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        cell.layer.cornerRadius = 20
        return cell
    }
    
}

//MARK: Using UITextViewDelegate Methods To Control The Note TextView
extension AddToDoTableViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .darkGray
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Please Enter Note Here"
            textView.textColor = .lightGray
        }
    }
}
