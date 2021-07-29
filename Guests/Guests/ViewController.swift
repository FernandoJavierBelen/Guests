//
//  ViewController.swift
//  Guests
//
//  Created by Fernando Belen on 26/07/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var womenNames: [String] = []
    var menNames: [String] = []
    
    var nameTextField: UITextField?
    
    @IBOutlet var textField: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var tableView1: UITableView!
    @IBOutlet var tableView2: UITableView!
    @IBOutlet var gander: UISwitch!
    @IBOutlet var totalWomans: UILabel!
    @IBOutlet var totalMens: UILabel!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Guests"
        gander.onTintColor = UIColor.black
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableView1 {
            return womenNames.count
        }else{
            return menNames.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableView1 {
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let name = womenNames[indexPath.row]
            cell1.textLabel?.text = name
            return cell1
            
        }else{
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
            let name = menNames[indexPath.row]
            cell2.textLabel?.text = name
            return cell2
        }
        
    }

    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if tableView == tableView1 {
            
            let deleteAction = UIContextualAction(style: .destructive, title: nil) { action, view, boolAction in
            
                let alertConfirm = UIAlertController(title: nil, message: "Delete name?", preferredStyle: .actionSheet)
                
                alertConfirm.addAction(UIAlertAction(title: "Yes, delete.", style: .destructive, handler: { action in
                    
                    self.womenNames.remove(at: indexPath.row)
                    self.tableView1.performBatchUpdates {
                    self.tableView1.deleteRows(at: [indexPath], with: .fade)
                    let total = Int(self.womenNames.count) - 0
                    self.totalWomans.text = "\(total)"
                        
                    } completion: { completed in
                        self.alertDialogWithImage2(msg: "Woman  name removed.", Icon: #imageLiteral(resourceName: "woman-user"))
                        print("Removed")
                    }
                }))
                
                alertConfirm.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                }))
                
                self.present(alertConfirm, animated: true) {}
                print("Delete action!!")
            }
            deleteAction.image = UIImage(systemName: "trash")
            let editAction = UIContextualAction(style: .normal, title: "Cancel") { action, view, boolAction in
                boolAction(true)
            }
            editAction.backgroundColor = UIColor.darkText
            return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
        }else {
            
            let deleteAction2 = UIContextualAction(style: .destructive, title: nil) { action, view, boolAction in
            
            let alertConfirm = UIAlertController(title: nil, message: "Delete name?", preferredStyle: .actionSheet)
                    alertConfirm.addAction(UIAlertAction(title: "Yes, delete.", style: .destructive, handler: { action in
                    
                    self.menNames.remove(at: indexPath.row)
                    self.tableView2.performBatchUpdates {
                    self.tableView2.deleteRows(at: [indexPath], with: .fade)
                    let total2 = Int(self.menNames.count) - 0
                        self.totalMens.text = "\(total2)"
                        
                    } completion: { completed in
                        
                        self.alertDialogWithImage3(msg: "Man name removed.", Icon: #imageLiteral(resourceName: "man-user"))
                        print("Remove")
                    }
                    
                }))
                
                alertConfirm.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
                }))
                        self.present(alertConfirm, animated: true) {}
                        print("Delete action!!")
            }
            deleteAction2.image = UIImage(systemName: "trash")
            
            let editAction2 = UIContextualAction(style: .normal, title: "Cancel") { action, view, boolAction in
                boolAction(true)
            }
            editAction2.backgroundColor = UIColor.darkText
            
            return UISwipeActionsConfiguration(actions: [deleteAction2,editAction2])
        }
    }
 
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if tableView == tableView1 {
            
            let edit = UIContextualAction(style: .normal, title: "Edit") { action, view, boolAction in
                boolAction(true)

                let editSelect = self.womenNames[indexPath.row]
                let dialogMessage = UIAlertController(title: "Edit", message: "Edit name of...", preferredStyle: .alert)
                let update = UIAlertAction(title: "Update", style: .default) { (action) in
                    let updatedName = self.nameTextField?.text!
                    self.womenNames[indexPath.row] = updatedName!
                    DispatchQueue.main.async {
                        self.tableView1.reloadData()
                        print("Data Has Been Update in Table Woman.")
                        self.alertDialogWithImage4(msg: "Updated name.", Icon: #imageLiteral(resourceName: "pen"))
                    }
                }
                let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    print("Edit Operation Cancelled by User.")
                   
                }
                dialogMessage.addAction(update)
                dialogMessage.addAction(cancel)
                dialogMessage.addTextField { (textfield) in
                    self.nameTextField = textfield
                    self.nameTextField?.placeholder = "Update Name Here."
                    self.nameTextField?.text = editSelect
                }
                self.present(dialogMessage, animated: true, completion: nil)
            }
            edit.backgroundColor = UIColor.black
            
            return UISwipeActionsConfiguration(actions: [edit])
        }else {
            
            let edit = UIContextualAction(style: .normal, title: "Edit") { action, view, boolAction in
                boolAction(true)
                
                let editSelect = self.menNames[indexPath.row]
                let dialogMessage = UIAlertController(title: "Edit", message: "Edit name of...", preferredStyle: .alert)
                let update = UIAlertAction(title: "Update", style: .default) { (action) in
                    let updatedName = self.nameTextField?.text!
                    
                    self.menNames[indexPath.row] = updatedName!
                    DispatchQueue.main.async {
                        self.tableView2.reloadData()
                        print("Data Has Been Update in Table Man.")
                        self.alertDialogWithImage4(msg: "Updated name.", Icon: #imageLiteral(resourceName: "pen"))
                    }
                }
                let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                    print("Edit Operation Cancelled by User.")
                }
                dialogMessage.addAction(update)
                dialogMessage.addAction(cancel)
                dialogMessage.addTextField { (textfield) in
                    self.nameTextField = textfield
                    self.nameTextField?.placeholder = "Update Name Here."
                    self.nameTextField?.text = editSelect
                }
                self.present(dialogMessage, animated: true, completion: nil)
            }
            edit.backgroundColor = UIColor.black
            
            return UISwipeActionsConfiguration(actions: [edit])
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        
        if textField.text != "" {
            
            if gander.isOn {
                womenNames.append(textField.text!)
                tableView1.reloadData()
                totalWomans.text = String(womenNames.count)
            }else{
                menNames.append(textField.text!)
                tableView2.reloadData()
                totalMens.text = String(menNames.count)
            }
        }else {
            alertDialogWithImage(msg: "Error, enter name.", Icon: #imageLiteral(resourceName: "error"))
        }
        self.textField.resignFirstResponder()
        textField.text = ""
    }
    
   override func touchesBegan(_ touches: Set<UITouch>, with: UIEvent?) {
        self.view.endEditing(true)
    }


    func alertDialogWithImage(msg : String, Icon : UIImage) {

        let alert = UIAlertController(title: " ", message: msg, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (action) in

            }
            alert.addAction(cancel)
            alert.view.tintColor = UIColor.black
            let imageView = UIImageView(frame: CGRect(x: 115, y: 2, width: 35, height: 35))
            imageView.image = #imageLiteral(resourceName: "error")
            alert.view.addSubview(imageView)
            self.present(alert, animated: true, completion: nil)
    }
    
    func alertDialogWithImage2(msg : String, Icon : UIImage) {

        let alert = UIAlertController(title: " ", message: msg, preferredStyle: UIAlertController.Style.alert)

        let cancel = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (action) in

            }
            alert.addAction(cancel)
            alert.view.tintColor = UIColor.black
            let imageView = UIImageView(frame: CGRect(x: 118, y: 4, width: 30, height: 35))
            imageView.image = #imageLiteral(resourceName: "woman-user")
            alert.view.addSubview(imageView)
            self.present(alert, animated: true, completion: nil)
    }
    
    func alertDialogWithImage3(msg : String, Icon : UIImage) {

        let alert = UIAlertController(title: " ", message: msg, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (action) in

            }
            alert.addAction(cancel)
            alert.view.tintColor = UIColor.black
            let imageView = UIImageView(frame: CGRect(x: 118, y: 2, width: 38, height: 42))
            imageView.image = #imageLiteral(resourceName: "man-user")
            alert.view.addSubview(imageView)
            self.present(alert, animated: true, completion: nil)
    }
    
    func alertDialogWithImage4(msg : String, Icon : UIImage) {

        let alert = UIAlertController(title: " ", message: msg, preferredStyle: UIAlertController.Style.alert)
        let cancel = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel) { (action) in

            }
            alert.addAction(cancel)
            alert.view.tintColor = UIColor.black
            let imageView = UIImageView(frame: CGRect(x: 118, y: 2, width: 38, height: 38))
            imageView.image = #imageLiteral(resourceName: "pen")
            alert.view.addSubview(imageView)
            self.present(alert, animated: true, completion: nil)
    }
}

