//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Sergio Cardoso on 10/04/18.
//  Copyright © 2018 Sergio Cardoso. All rights reserved.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

	var categories = [Category]()
	let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
	
	
	override func viewDidLoad() {
        super.viewDidLoad()
		loadCategory()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return categories.count
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
		cell.textLabel?.text = categories[indexPath.row].name
		
		return cell
    }
	
	//MARK - tableView delegate methods
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		//tableView.deselectRow(at: indexPath, animated: true)
		performSegue(withIdentifier: "goToItems", sender: self)
		
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		let destinationVC = segue.destination as! TodoListViewController
		
		if let indexPath = tableView.indexPathForSelectedRow{
			destinationVC.selectedCategory = categories[indexPath.row]
		}
	}
	
	
	
	//MARK - Data manipulation
	func saveCategory(){
		do{
			try context.save()
		}catch {
			print("Error creating new gategory \(error)")
		}
		tableView.reloadData()
	}
	
	func loadCategory(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
		let request : NSFetchRequest<Category> = Category.fetchRequest()
		do{
			categories = try context.fetch(request)
		}catch {
			print("Error fetching data from context \(error)")
		}
		tableView.reloadData()
	}
	
	//MARK - Add new items
	
	@IBAction func addButtonPressed(_ sender: Any) {
		
		var textField = UITextField()
		let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
		
		let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
			
			let newCategory = Category(context: self.context)
			newCategory.name = textField.text!
			
			self.categories.append(newCategory)
			self.saveCategory()
			
		}
		
		alert.addAction(action)
		alert.addTextField { (categoryTxtField) in
			textField = categoryTxtField
			categoryTxtField.placeholder = "Create New Category"
		}
		
		present(alert, animated: true, completion: nil)
	}
	
}
