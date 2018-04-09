//
//  ViewController.swift
//  Todoey
//
//  Created by Sergio Cardoso on 08/04/18.
//  Copyright © 2018 Sergio Cardoso. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

	
	var itemArray = [Item]()

	
	//creates a path for plist file.
	let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
	
	override func viewDidLoad() {
		super.viewDidLoad()
	
		loadItems()
	}

	
	//MARK - TableView DataSource Methods
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return itemArray.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
		
		let item = itemArray[indexPath.row]
		cell.textLabel?.text = item.title
		cell.accessoryType = item.done ? .checkmark : .none
		
		return cell
	}
	
	//MARK - TableView Delegate Methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		tableView.deselectRow(at: indexPath, animated: true)
		itemArray[indexPath.row].done = !itemArray[indexPath.row].done
		saveItems()
		tableView.reloadData()
		
	}
	
	
	//MARK - Add new Items
	@IBAction func addBtnPressed(_ sender: Any) {
		var textField = UITextField()
		let alert = UIAlertController(title: "Add a New Item", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
			let newItem = Item()
			newItem.title = textField.text!
			
			self.itemArray.append(newItem)
			self.saveItems()
		}
		
		alert.addTextField { (alertTextField) in
			alertTextField.placeholder = "Create New Item"
			textField = alertTextField
		}
		alert.addAction(action)
		present(alert, animated: true, completion: nil)

	}
	
	func saveItems(){
		let encoder = PropertyListEncoder()
		
		do {
			let data = try encoder.encode(itemArray)
			try data.write(to: dataFilePath!)
		}catch {
			print("Error enconding item array, \(error)")
		}
		self.tableView.reloadData()
	}
	func loadItems(){
		if let data = try? Data(contentsOf: dataFilePath!){
			let decoder = PropertyListDecoder()
			do {
				itemArray = try decoder.decode([Item].self, from: data)
			} catch {
				print("Error decoding array \(error)")
			}
		}
	
	}
	
}

