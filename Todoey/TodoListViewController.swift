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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
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


}

