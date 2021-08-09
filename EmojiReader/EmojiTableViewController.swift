//
//  EmojiTableViewController.swift
//  EmojiReader
//
//  Created by wozdabady on 07.08.2021.
//

import UIKit

class EmojiTableViewController: UITableViewController {
    
    // Записи
    var objects = [
        Emoji(emoji: "😇", name: "Angel", description: "Ангельская улыбка, добрые побуждения", isFavourite: false),
        Emoji(emoji: "😎", name: "Cool man", description: "Пока на расслабоне, на чилле", isFavourite: false),
        Emoji(emoji: "😏", name: "Nice cock", description: "Awesome balls", isFavourite: false),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Emoji Reader"
        // Кнопка режима редактирования
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Кастомный cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.setDataForCell(object: object)

        return cell
    }
    
    // Кнопка удаления в режиме редактирования
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Поведение при нажатии кнопки удаления в режиме редактирования
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // Кнопка перемещения
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    // Поведение при перемещении записей
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // Удаляем запись из старого индекса и вставляем в новый, обновив TableView
        let movedEmoji = objects.remove(at: sourceIndexPath.row)
        objects.insert(movedEmoji, at: destinationIndexPath.row)
        tableView.reloadData()
    }

}
