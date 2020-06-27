//
//  HistoryVC.swift
//  Smart Lock
//
//  Created by Rahul Pawar on 24/04/20.
//  Copyright © 2020 Rahul Pawar. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import AnimatedGradientView
import SwipeCellKit



class HistoryVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
   
    
    
    @IBOutlet weak var animatedView: UIImageView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var cellDataArray : [CellModel] = [CellModel]()
    var customCell = CustomCell()
    var profile = ProfileVC()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = 83
               let animatedGradient = AnimatedGradientView(frame: view.bounds)
               animatedGradient.direction = .up
               animatedGradient.animationValues = [(colors: ["#2BC0E4", "#F7D80F"], .up, .axial),
        //                                        (colors: ["#833ab4", "#fd1d1d", "#fcb045"], .right, .axial)]
        //     (colors: ["#003973", "#E5E5BE"], .down, .axial)]
              (colors: ["#f5e76e", "#f7d04d", "#fcb03d"], .left, .axial)]
                animatedView.addSubview(animatedGradient)
        // Do any additional setup after loading the view.
        
        
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCell")
        
        tableView.allowsSelectionDuringEditing = true
        historyData()
        
    }
    


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellDataArray.count
     }
     
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! SwipeTableViewCell
//        cell.delegate = self
//        return cell
//    }
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomCell
        
       
        
        cell.statusLabel.text = cellDataArray[indexPath.row].status
        cell.dateLabel.text = cellDataArray[indexPath.row].date
        cell.timeLabel.text = cellDataArray[indexPath.row].time
        
        if cell.statusLabel.text == "Unlocked"{
            cell.statusImage.image = UIImage(named: "unlock-1")
            cell.statusLabel.textColor = UIColor.green
        }else{
            cell.statusImage.image = UIImage(named: "lock-1")
            cell.statusLabel.textColor = UIColor.red
        }
        
        return cell
     }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = cellDataArray[indexPath.row].id
        print("#################################")
        print(id)
        UserDefaults.standard.set(id, forKey: "savedID")
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
           return true
       }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        
           let deletingId = UserDefaults.standard.object(forKey: "savedID")
                        let uid = Auth.auth().currentUser?.uid as! String
                        let ref = Database.database().reference()
                        ref.child("Users").child(uid).child("History").queryOrdered(byChild: "ID").queryEqual(toValue: deletingId).observeSingleEvent(of: .childAdded) { (snapshot) in
                            snapshot.ref.removeValue()
        
                            self.cellDataArray.remove(at: indexPath.row)
                            self.tableView.deleteRows(at: [indexPath], with: .automatic)
                            self.tableView.reloadData()
                            ref.keepSynced(true)
                        }
        
        
        
        
    }
    
    
    
    //TODO: Create the retrieveMessages method here:
    
    
    func historyData(){
        let uid = Auth.auth().currentUser?.uid as! String
        let lockDB = Database.database().reference().child("Users").child(uid).child("History")
        
        
        
        
        lockDB.observe(.childAdded) { (snapshot) in
                    let snapshotValue = snapshot.value as! Dictionary<String,Any>
        
                    let state = snapshotValue["state"]!
                    let date = snapshotValue["Date"]!
                    let time = snapshotValue["Time"]!
                    let id = snapshotValue["ID"]!
                    print(state, date, time, id)
        
                    let cellModel = CellModel()
                    cellModel.status = state as! String
                    cellModel.date = date as! String
                    cellModel.time = time as! String
                    cellModel.id = id as! String
                    self.cellDataArray.append(cellModel)
                    self.tableView.reloadData()
        }
        
       
        
        
       

        
        
//        lockDB.observe(.childChanged) { (snapshot) in
//            let snapshotValue = snapshot.value as! Dictionary<String,Any>
//
//            let state = snapshotValue["state"]!
//            let date = snapshotValue["Date"]!
//            let time = snapshotValue["Time"]!
//            let id = snapshotValue["ID"]!
//            print(state, date, time, id)
//
//            let cellModel = CellModel()
//            cellModel.status = state as! String
//            cellModel.date = date as! String
//            cellModel.time = time as! String
//            cellModel.id = id as! String
//            self.cellDataArray.append(cellModel)
//            self.tableView.reloadData()
//
//            }
         
            
            
            
         
     }
   

}
//extension HistoryVC: SwipeTableViewCellDelegate{
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//             let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//                 // handle action by updating model with deletion
//                let deletingId = UserDefaults.standard.object(forKey: "savedID")
//                let uid = Auth.auth().currentUser?.uid as! String
//                let ref = Database.database().reference()
//                ref.child("Users").child(uid).child("Smart Lock").queryOrdered(byChild: "ID").queryEqual(toValue: deletingId).observeSingleEvent(of: .childAdded) { (snapshot) in
//                    snapshot.ref.removeValue()
//                    
//                    self.cellDataArray.remove(at: indexPath.row)
//                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
//                    self.tableView.reloadData()
//                }
//                
//                
//             }
//
//             // customize the action appearance
//             deleteAction.image = UIImage(named: "delete-icon")
//
//             return [deleteAction]
//    }
//    
//    
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//         var options = SwipeOptions()
//               options.expansionStyle = .destructive
//               options.transitionStyle = .border
//               return options
//    }
//  
// 
//    
//    
//}
