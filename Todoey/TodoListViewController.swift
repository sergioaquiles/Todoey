//
//  ViewController.swift
//  Todoey
//
//  Created by Sergio Cardoso on 08/04/18.
//  Copyright © 2018 Sergio Cardoso. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

	
	var itemArray = ["Find Mike", "Buy Eggos", "Destroy Demogorgon"]
	let defaults = UserDefaults.standard
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let items = defaults.array(forKey: "TodoListArray") as? [String] {
			itemArray = items
		}
		
	}

	
	//MARK - TableView DataSource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
		cell.textLabel?.text = itemArray[indexPath.row]
		return cell
	}
	
	//MARK - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
			tableView.cellForRow(at: indexPath)?.accessoryType = .none
		}else {
			tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
		}
		
	}
	//MARK - Add new Items
	@IBAction func addBtnPressed(_ sender: Any) {
		var textField = UITextField()
		let alert = UIAlertController(title: "Add a New Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			self.itemArray.append(textField.text!)
			self.defaults.set(self.itemArray, forKey: "TodoListArray")
			self.tableView.reloadData()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create New Item"
			textField = alertTextField
		}
		alert.addAction(action)
		present(alert, animated: true, completion: nil)

	}
	
}

