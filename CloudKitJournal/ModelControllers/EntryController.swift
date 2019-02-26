//
//  EntryController.swift
//  CloudKitJournal
//
//  Created by Ben Huggins on 2/25/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import CloudKit

class EntryController{
    
    var entries: [Entry] = []
    
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func save(entry: Entry, completion: @escaping (Bool) -> Void) {
        
        let entryRecord = CKRecord(entry: entry)
        privateDB.save(entryRecord) { (record, error) in
            
            if let error = error {
                print("error saving: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let record = record, let returnMessage = Entry(ckRecord: record) {
                self.entries.insert(returnMessage, at: 0)
                
                completion(true)
                
            }
        }
    }
    
    func addEntryWith(title: String, bodyText: String, completion: @escaping (Bool) -> Void) {
        let entry = Entry(title: title, bodyText: bodyText)
        save(entry: entry) { (success) in
            if success {
                self.entries.append(entry)
                completion(true)
            }else {
                completion(false)
            }
        }
    }
    
    func fetchEntries(completion: @escaping (Bool) -> Void) {
        
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: Constants.recordKey, predicate: predicate)
        
        
        privateDB.perform(query, inZoneWith: nil) { (records, error) in
            if let error = error {
                print("error fetching item from Cloudkit : \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let records = records else {completion(false); return }
            
            let messagesReturned = records.compactMap({ Entry(ckRecord: $0 )})
            
            self.entries = messagesReturned
            
            completion(true)
        }
    }
}
