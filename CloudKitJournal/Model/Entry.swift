//
//  Entry.swift
//  CloudKitJournal
//
//  Created by Ben Huggins on 2/25/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import CloudKit


struct Constants {
    static let recordKey = "Entry"
    static let titleKey = "Title"
//    static let ckRecordIdKey = "ckRecordID"
    static let bodyKey = "Body"
}

class Entry {
   
    var title: String
    var bodyText: String
    var ckRecordID: CKRecord.ID
    
    init(title: String, bodyText: String, ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)){
        self.title = title
        self.bodyText = bodyText
        self.ckRecordID = ckRecordID
  
}
    
    convenience init?(ckRecord: CKRecord) {
       
        guard let title = ckRecord[Constants.titleKey] as? String,
            let bodyText = ckRecord[Constants.bodyKey] as? String else { return nil}
        
        
        self.init(title: title, bodyText: bodyText, ckRecordID: ckRecord.recordID)
    }
    
}

extension CKRecord{
    
    convenience init(entry: Entry){
        
        self.init(recordType: Constants.recordKey, recordID: entry.ckRecordID)
        
        self.setValue(entry.title, forKey: Constants.titleKey)
        self.setValue(entry.bodyText, forKey: Constants.bodyKey)
//        self.setValue(entry.ckRecordID, forKey: Constants.recordKey)
        
}
}
