import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    //An interface to the userDefaults Database class where u store key value pairs persistently across launches of the app.
//    let defaults = UserDefaults.standard
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        
//        let newItem = Item()
//        newItem.title = "Buy Fruits"
//        itemArray.append(newItem)
//        
//        let newItem2 = Item()
//        newItem2.title = "Buy Eggs"
//        itemArray.append(newItem2)
//        
//        let newItem3 = Item()
//        newItem3.title = "Buy Veggies"
//        itemArray.append(newItem3)
//        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]{
//            itemArray = items
//        }
        
        loadItems()
        
        
    }
    
    //Mark - TableView DataSource Methods (For making a cell & counting the no. of rows.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator ==>
        //value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        return cell
    }
    
    //Mark - TableView Delegate Methods - (For selecting rows &
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])

        //given condition to check whether the cell is checkmark or not.
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true) //to deselect the row
    }
    
    // Mark -- Add new Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        //Pop-Up Message
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //when button clicked , what will happen?!
            //Todo - write condition statement so that empty string not be append to the itemArray
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
//          self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            self.saveItems()
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder="Create new items"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    //MARK - Model Manupulation Methods
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to : dataFilePath!)
        }catch{
            print("Error encoding item array, \(error)")
        }
        self.tableView.reloadData() //To refresh the list of array
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder  = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data)
            }catch{
                print("Error decoding item array, \(error)")
            }
        }
    }
}










