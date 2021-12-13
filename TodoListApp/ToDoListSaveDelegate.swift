//
//  ControlToDoList.swift
//  TodoListApp
//
//  Created by admin on 13/12/2021.
//

import UIKit

protocol ToDoListSaveDelegate: AnyObject {
    func saveNewItem(title: String, note: String, date: Date)
}
