//
//  NewEmojiTableViewController.swift
//  EmojiReader
//
//  Created by wozdabady on 10.08.2021.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {
    
    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)

    @IBOutlet weak var emojeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
   
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func textChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let emojiText = emojeTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = (!emojiText.isEmpty &&
                                    !nameText.isEmpty &&
                                    !descriptionText.isEmpty)
    }
    
    private func updateUI() {
        emojeTextField.text = emoji.emoji
        nameTextField.text = emoji.name
        descriptionTextField.text = emoji.description
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "saveSegue" else {return}
        
        let emoji = emojeTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        
        self.emoji = Emoji(emoji: emoji, name: name, description: description, isFavourite: self.emoji.isFavourite)
    }
    
    
}
