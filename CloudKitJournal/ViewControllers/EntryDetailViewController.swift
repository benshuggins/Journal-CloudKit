//
//  EntryDetailViewController.swift
//  CloudKitJournal
//
//  Created by Ben Huggins on 2/25/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entryController: EntryController!
    
    var entry: Entry?{
        didSet{
            loadViewIfNeeded()
            updateView()
        }
    }
    
    
    func updateView() {
        entryTextField.text = entry?.title
        textViewDisplay.text = entry?.bodyText
    }
    @IBOutlet weak var entryTextField: UITextField!
    
    @IBOutlet weak var textViewDisplay: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryTextField.delegate = self as UITextFieldDelegate
   
       
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
     entryTextField.text = " "
     textViewDisplay.text = " "
    
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
    
        guard let title = entryTextField.text, let bodyText = textViewDisplay.text else {return}
        
     entryController.addEntryWith(title: title, bodyText: bodyText) { (success) in
            if success{
                print("SUCCESS creating new entry")
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }else {
                print("Failure creating new entry")
            }
    }
   
   

}
    
}
extension EntryDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        entryTextField.resignFirstResponder()
    return true
    }
    
}

