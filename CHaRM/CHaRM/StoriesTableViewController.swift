//
//  StoriesTableViewController.swift
//  CHaRM
//
//  Created by Annette Cochran on 1/16/19.
//  Copyright © 2019 JID8306. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseCore

class StoriesTableViewController: UITableViewController {

    var zipCodeRef: DatabaseReference!
    var materialRef: DatabaseReference!
    var currentMaterial = ""
    var updatedInt = 0
    
    
    @IBOutlet weak var zipCode: UITextField!
    
    
    @IBAction func submitButton(_ sender: Any) {
        addZipCode()
        addMaterials()
    }
    
    func addZipCode() {
        let key = zipCodeRef.childByAutoId().key
        let zip = ["id": key as Any, "userZip": zipCode.text! as String]
        
        zipCodeRef.child(key!).setValue(zip) //Aborts execution if zip is null
    }
    
    func addMaterials() {
//        let key = zipCodeRef.childByAutoId().key
//        let name = str
//        let number = 3
//        let materials = ["id": name, "Materials": number] as [String : Any]
//
//        materialRef.child(key!).setValue(materials)
        _ = Database.database().reference().root.child("Materials Brought").child(currentMaterial).observeSingleEvent(of: .value) { (DataSnapshot) in
            let valToUpdate = DataSnapshot.value as? NSNumber
            print("value to update is: ", valToUpdate?.intValue as Any)
            self.updatedInt = (valToUpdate?.intValue)! //aborts if value is nil fix during code review if needed also hi
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            print("updated int before increment is:", self.updatedInt)
            self.updatedInt = self.updatedInt + 1
            print("updated int is now:, ", self.updatedInt)
            _ = Database.database().reference().root.child("Materials Brought").child(self.currentMaterial).setValue(self.updatedInt)
        }
//        print("updated int before increment is:", updatedInt)
//        //updatedInt = updatedInt + 1
//        print("updated int is now:, ", updatedInt)
//        _ = Database.database().reference().root.child("Materials Brought").child(currentMaterial).setValue(updatedInt)
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.setEditing(true, animated: false)
        zipCodeRef = Database.database().reference(withPath:"Zipcode")
        materialRef = Database.database().reference(withPath:"Materials Brought/"+currentMaterial)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    struct Recyclable {
        
        var id : Int
        var section : Int
        var title : String
        var text : String
        
    }
    
    var itemList = [
        [Recyclable(id: 1, section: 0, title: "Paint", text: "Latex and Oil Based\n(First fifty pounds are free each additional pound is $.25.)"),
        Recyclable(id: 2, section: 0, title: "Household Chemicals", text: "pesticides, herbicides, household cleaners, etc."),
        Recyclable(id: 3, section: 0, title: "Electronics", text: "TV’s must be intact.Electronics include all items that required electricity"),
        Recyclable(id: 4, section: 0, title: "Tires", text:""),
        Recyclable(id: 5, section: 0, title: "Mattresses", text:""),
        Recyclable(id: 6, section: 0, title: "Propane Tanks", text:""),
        Recyclable(id: 7, section: 0, title: "Large Appliances", text: "Refrigerators, Stoves, Dishwashers , Dehumidifiers, AC units"),
        Recyclable(id: 8, section: 0, title: "Thermometers", text: ""),
        Recyclable(id: 9, section: 0, title: "Smoke Detectors", text: ""),
        Recyclable(id: 10, section: 0, title: "Bulbs", text: ""),
        Recyclable(id: 11, section: 0, title: "CFL Bulbs", text: ""),
        Recyclable(id: 12, section: 0, title: "Toilets", text: "Seats and all hardware must be removed")],
        [Recyclable(id: 13, section: 1, title: "Plastics/clean, dry, empty plastic bags/ film packaging/grocery bags", text: ""),
        Recyclable(id: 14, section: 1, title: "Plastic food containers", text: "#1-#2-#5, clean and dry"),
        Recyclable(id: 15, section: 1, title: "Paper", text: "magazines/office paper/newspaper/phone books"),
        Recyclable(id: 16, section: 1, title: "Glass bottles and jars", text: "food grade only"),
        Recyclable(id: 17, section: 1, title: "Metal", text: "steel, iron, brass, aluminum, or copper"),
        Recyclable(id: 18, section: 1, title: "Aluminum Cans", text: ""),
        Recyclable(id: 19, section: 1, title: "Cardboard", text: ""),
        Recyclable(id: 20, section: 1, title: "Ink Printer Cartridges", text: "no toner"),
        Recyclable(id: 21, section: 1, title: "Textiles", text: ""),
        Recyclable(id: 22, section: 1, title: "Styrofoam", text: "please wash"),
        Recyclable(id: 23, section: 1, title: "Batteries", text: "Zinc Carbon, Button, Lithium, Rechargeable, Car"),
        Recyclable(id: 24, section: 1, title: "Household fats/oil/grease", text: ""),
        Recyclable(id: 25, section: 1, title: "Waxed Cartons", text: "Broth, Milk, Juice"),
        Recyclable(id: 26, section: 1, title: "Wine Corks", text: ""),
        Recyclable(id: 27, section: 1, title: "Political signs", text: "")],
        [Recyclable(id: 28, section: 2, title: "Books", text: ""),
        Recyclable(id: 29, section: 2, title: "Musical Instruments", text: ""),
        Recyclable(id: 30, section: 2, title: "Sports equiptment", text: ""),
        Recyclable(id: 31, section: 2, title: "Bikes", text: ""),
        Recyclable(id: 32, section: 2, title: "Textiles", text: ""),
        Recyclable(id: 33, section: 2, title: "Furniture in usable condition", text: "No Office Furniture"),
        Recyclable(id: 34, section: 2, title: "Household items in usable condition", text: ""),
        Recyclable(id: 30, section: 2, title: "Clothing", text: "")],
    ]
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 12
        } else if section == 1 {
            return 15
        } else {
            return 8
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabelCell", for: indexPath)
        print(itemList[indexPath.section][indexPath.row].title)
        cell.textLabel?.text = itemList[indexPath.section][indexPath.row].title
        cell.detailTextLabel?.text = itemList[indexPath.section][indexPath.row].text
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Items with Material Processing Fee"
        }
        if (section == 1) {
            return "Items with No Fee"
        }
        else {
            return "Items for ReUse (No Fee)"
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(self.itemList[indexPath.row].title)
        currentMaterial = self.itemList[indexPath.row].title
        //addMaterials(str:self.itemList[indexPath.row].title)
        //        let selected = itemList[indexPath.row]
        //        print selected
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
