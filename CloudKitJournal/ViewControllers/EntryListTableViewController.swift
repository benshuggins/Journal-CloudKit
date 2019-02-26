//
//  EntryListTableViewController.swift
//  CloudKitJournal
//
//  Created by Ben Huggins on 2/25/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController {
    
    let entryController = EntryController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryController.fetchEntries(completion: { (success) in
            if success{
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    
                }
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
//        entryController.fetchEntries(completion: { (success) in
//            if success{
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        })
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return entryController.entries.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)
        
        let entries = entryController.entries[indexPath.row]
        
        cell.textLabel?.text = entries.title
        cell.detailTextLabel?.text = entries.bodyText
        
        return cell
    }
    
    
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
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? EntryDetailViewController
        destinationVC?.entryController = self.entryController
        if segue.identifier == "toDetailVC"{
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            let entry = entryController.entries[indexPath.row]
            destinationVC?.entry = entry
        }
    }
}
