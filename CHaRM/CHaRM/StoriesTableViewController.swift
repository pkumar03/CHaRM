//
//  StoriesTableViewController.swift
//  CHaRM

import UIKit
import FirebaseDatabase
import FirebaseCore

var paintIndv = 0
var myDict = ["Batteries" : 0, "Bikes" : 0, "Paint" : 0, "Aluminum Cans" : 0, "Books" : 0, "Bulbs" : 0, "Cardboard" : 0, "Clothing" : 0, "Electronics" : 0, "Furniture in usable condition" : 0, "Glass bottles and jars" : 0, "Household Chemicals" : 0, "Household fats or oil or grease" : 0, "Household items in usable condition" : 0, "Ink Printer Cartridges" : 0, "Large Appliances" : 0, "Mattresses" : 0, "Metal" : 0, "Musical Instruments" : 0, "Paper" : 0, "Plastic food containers" : 0, "Plastic or grocery bags" : 0, "Political signs" : 0, "Propane Tanks" : 0, "Smoke Detectors" : 0, "Sports equipment" : 0, "Styrofoam" : 0, "Textiles" : 0, "Thermometers" : 0, "Tires" : 0, "Toilets" : 0, "Waxed Cartons" : 0, "Wine Corks" : 0]

class StoriesTableViewController: UITableViewController {

    var zipCodeRef: DatabaseReference!
    var materialRef: DatabaseReference!
    var currentMaterial = ""
    var updatedInt = 0
    var ourArray = [String]()
    
   // var myDict = ["Aluminum Cans" : 0, "Bikes" : 0, "Paint" : 0]
    
    let defaults = UserDefaults.standard
    
    enum zipCodeError : Error {
        //wrong length or not entered
        case wrongLength
        case wrongChars
    }
    
    //var materialsUpdateDict = UserDefaults.standard.value(forKey: "dict") as! [String: Int]
    
    @IBOutlet weak var zipCode: UITextField!
    
    @IBAction func submitButton(_ sender: Any) {
        do {
            try addZipCode()
        } catch  zipCodeError.wrongLength {
            let wrongLengthAlert = UIAlertController(title: "Please enter 5-digit zip code", message: "", preferredStyle: .alert)
            wrongLengthAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(wrongLengthAlert, animated: true)
            print("Please enter 5-digit zip code")
        } catch zipCodeError.wrongChars {
            let wrongCharsAlert = UIAlertController(title: "Please enter zip code with numbers only", message: "", preferredStyle: .alert)
            wrongCharsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(wrongCharsAlert, animated: true)
            print("Please enter zip code with numbers only")
        } catch {
            print("Unexpected error: please check that you entered zip code correctly")
        }
        addMaterials()
    }
    
    func addZipCode() throws {
        let key = zipCodeRef.childByAutoId().key
        let zip = ["id": key as Any, "userZip": zipCode.text! as String]
        let zipString = zipCode.text!
        if (zipString.count != 5) {
            throw zipCodeError.wrongLength
        }
        for index in zipString.indices {
            if (zipString[index] > "9") {
                throw zipCodeError.wrongChars
            }
        }
        //print(zipCode.text)
        
        zipCodeRef.child(key!).setValue(zip) //Aborts execution if zip is null
    }
    
    func addMaterials() {
        
        //Please ask me (Pranay) before changing anything in this function
        //I added a semaphore to control access to currentMaterial + made a new dispatch queue and used gcd to control execution of the threads
        
        let queue = DispatchQueue(label: "com.gcd.myQueue", attributes: .concurrent)
        let semaphore = DispatchSemaphore(value: 1)

        for i in ourArray {
            
            myDict[i] = myDict[i]! + 1
            print(myDict)
            queue.async {
            
                semaphore.wait()
                self.currentMaterial = i
                
                _ = Database.database().reference().root.child("Materials Brought").child(self.currentMaterial).observeSingleEvent(of: .value) { (DataSnapshot) in
                    let valToUpdate = DataSnapshot.value as? NSNumber
                    self.updatedInt = (valToUpdate?.intValue)! //aborts if value is nil fix during code review if needed also hi
                }
            
                //look into putting a semaphore lock on currentMaterial
              
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    self.updatedInt = self.updatedInt + 1
                    _ = Database.database().reference().root.child("Materials Brought").child(self.currentMaterial).setValue(self.updatedInt)
                    semaphore.signal()
                }
            }
        }
        //defaults.set(materialsUpdateDict, forKey: "dict")
        persistData()
    }
    
    
    func persistData() {
        for (materials, number) in myDict {
            //defaults.integer(forKey: materials)
            if (myDict[materials] != 0) {
                if (defaults.value(forKey: materials) as? Int == nil) {
                    print(materials)
                }
                let oldNum = defaults.integer(forKey: materials)
                let newNum = number + oldNum
                print("Material: , Number:", materials,newNum)
                defaults.set(newNum, forKey: materials)
            }
        }
        //            if (i == "Paint"){
        //                paintIndv = paintIndv + 1
        //                defaults.set(paintIndv, forKey: "PaintKey")
        //                print (paintIndv, "Stores")
        //            }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        zipCode.borderStyle = UITextField.BorderStyle.roundedRect
        zipCode.keyboardType = UIKeyboardType.numberPad
        tableView.allowsMultipleSelectionDuringEditing = true
        tableView.setEditing(true, animated: false)
        zipCodeRef = Database.database().reference(withPath:"Zipcode")
        materialRef = Database.database().reference(withPath:"Materials Brought/"+currentMaterial)
        
        paintIndv = defaults.integer(forKey: "PaintKey")
//        materialsDictionary = ["Aluminum Cans" : 0, "Bikes" : 0, "Books" : 0]
//        print(materialsDictionary)
//        materialsDictionary = defaults.dictionary(forKey: "dict") as? [String : Int] ?? ["Please" : 0]
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
        [Recyclable(id: 13, section: 1, title: "Plastic or grocery bags", text: "Plastics/clean, dry, empty plastic bags/ film packaging/grocery bags"),
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
        Recyclable(id: 24, section: 1, title: "Household fats or oil or grease", text: ""),
        Recyclable(id: 25, section: 1, title: "Waxed Cartons", text: "Broth, Milk, Juice"),
        Recyclable(id: 26, section: 1, title: "Wine Corks", text: ""),
        Recyclable(id: 27, section: 1, title: "Political signs", text: "")],
        [Recyclable(id: 28, section: 2, title: "Books", text: ""),
        Recyclable(id: 29, section: 2, title: "Musical Instruments", text: ""),
        Recyclable(id: 30, section: 2, title: "Sports equipment", text: ""),
        Recyclable(id: 31, section: 2, title: "Bikes", text: ""),
        Recyclable(id: 32, section: 2, title: "Textiles", text: ""),
        Recyclable(id: 33, section: 2, title: "Furniture in usable condition", text: "No Office Furniture"),
        Recyclable(id: 34, section: 2, title: "Household items in usable condition", text: ""),
        Recyclable(id: 30, section: 2, title: "Clothing", text: "")],
    ]
    
    struct QuantityAlert {
        
        var prompt : String
        var message: String
        var textBoxLabel : String
        
    }
    
    var quantityAlerts = [
        QuantityAlert(prompt: "How many pounds of paint did you bring?", message: "First 50 lbs are free, each additional pound is $0.25", textBoxLabel: "# of lbs"),
        QuantityAlert(prompt: "How many pounds of chemicals did you bring?", message: "First 50 lbs are free, each additional pound is $0.25", textBoxLabel: "# of lbs"),
        QuantityAlert(prompt: "How many electronics did you bring?", message: "TV's and monitors: $15 each", textBoxLabel: "# of electronics"),
        QuantityAlert(prompt: "How many tires did you bring?", message: "First 2 are free, each additional tire is $2", textBoxLabel: "# of tires"),
        QuantityAlert(prompt: "How many sets of mattresses (set + box spring) did you bring?", message: "$10 per set", textBoxLabel: "# of sets"),
        QuantityAlert(prompt: "How many propane tanks did you bring?", message: "$10 per tank", textBoxLabel: "# of tanks"),
        QuantityAlert(prompt: "How many large appliances did you bring?", message: "Refrigerators, Stoves, Dishwashers, Dehumidifiers, AC units: $10 each", textBoxLabel: "# of appliances"),
        QuantityAlert(prompt: "How many thermometers did you bring?", message: "$5 per thermometer", textBoxLabel: "# of thermometers"),
        QuantityAlert(prompt: "How many smoke detectors did you bring?", message: "$5 per smoke detector", textBoxLabel: "# of smoke detectors"),
        QuantityAlert(prompt: "How many light bulbs did you bring?", message: "4ft & 6ft Fluorescent are free \nFirst 2 free, each additional bulb is $0.50", textBoxLabel: "# of bulbs"),
        QuantityAlert(prompt: "How many CFL bulbs did you bring?", message: "First 5 are free, each additional CFL bulb is $0.50", textBoxLabel: "# of bulbs"),
        QuantityAlert(prompt: "How many toilets did you bring?", message: "", textBoxLabel: "# of toilets"),
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
        //print(itemList[indexPath.section][indexPath.row].title)
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
        //print(self.itemList[indexPath.section][indexPath.row].title)
        if (indexPath.section == 0) {
            let quantityAlert = UIAlertController(title: quantityAlerts[indexPath.row].prompt, message: quantityAlerts[indexPath.row].message, preferredStyle: .alert)
            quantityAlert.addTextField { (textField:UITextField) in
                textField.placeholder = self.quantityAlerts[indexPath.row].textBoxLabel
                textField.keyboardType = UIKeyboardType.numberPad
            }
            quantityAlert.addAction(UIAlertAction(title: "Enter", style: .default, handler: nil))
            self.present(quantityAlert, animated: true)
        }
        ourArray.append(self.itemList[indexPath.section][indexPath.row].title)
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
