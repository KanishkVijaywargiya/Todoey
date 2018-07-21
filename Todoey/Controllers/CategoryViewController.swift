import UIKit
import RealmSwift
import ChameleonFramework

class CategoryViewController: SwipeTableViewController {
    
    let realm = try! Realm()
    
    var categories: Results<Category>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
        
        tableView.separatorStyle = .none
        
    }
    
    //MARK: - Table View Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return categories?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAt: indexPath)
        if let category = categories?[indexPath.row]{
            cell.textLabel?.text = category.name
            
            guard let categoryColor = UIColor(hexString: category.color)else{fatalError()}
            cell.backgroundColor = categoryColor
            cell.textLabel?.textColor = ContrastColorOf(categoryColor, returnFlat: true)
        }
        return cell
    }
    
    //MARK: - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true) //to deselect the row
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            let destinationVC = segue.destination as! TodoListViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedCategory = categories?[indexPath.row]
            }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        //Pop-Up Message
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            //when button clicked , what will happen?!
            
            let newCategory = Category()
            if !(textField.text?.isEmpty)!{
                newCategory.name = textField.text!
            }else{
                print("Category need to have a name!")
                return
            }
            newCategory.color = UIColor.randomFlat.hexValue()
            
            self.save(category: newCategory)
        }
        alert.addAction(action)

        alert.addTextField { (field) in
            textField = field
            field.placeholder="Add a new category"
        }
                present(alert,animated: true,completion: nil)
    }
    
    
    //MARK: - Data Manipulation methods
    //Save Data
    func save(category:Category){
        do{
            try realm.write {
                realm.add(category)
            }
        }catch{
            print("Error saving category, \(error)")
        }
        tableView.reloadData() //To refresh the list of array
    }
    //Read Data
    func loadCategories(){
        
        categories = realm.objects(Category.self).sorted(byKeyPath: "name", ascending: true)

        tableView.reloadData()
    }
    
    //MARK: - Delete Data From Swipe
    override func updateModel(at indexPath: IndexPath) {
        //this is to call the functions from superclass
        if let categoryForDeletion = self.categories?[indexPath.row]{
            do{
                try self.realm.write {
                    for item in categoryForDeletion.items{
                        self.realm.delete(item)
                    }
                    self.realm.delete(categoryForDeletion)
                }
            }catch{
                print("Error deleting category,\(error)")
            }
        }
    }
}



















