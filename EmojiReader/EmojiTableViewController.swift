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
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveSegue" else {return}
        
        let sourceViewController = segue.source as! NewEmojiTableViewController
        let emoji = sourceViewController.emoji
        
        let newIndexPath = IndexPath(row: objects.count, section: 0)
        objects.append(emoji)
        tableView.insertRows(at: [newIndexPath], with: .fade)
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
    
    //MARK: - Delete rows
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
    
    //MARK: - Move rows
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
    
    //MARK: - Leading Swipe Actions Configuration
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let done = doneAction(at: indexPath)
        let favourite = favouriteAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [done, favourite])
    }
    
    func doneAction(at indexPath: IndexPath) -> UIContextualAction {
        let action = UIContextualAction(style: .destructive, title: "Done") {
            (action, view, completion) in
            self.objects.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            completion(true)
        }
        action.backgroundColor = .systemGreen
        action.image = UIImage(systemName: "arrow.up.circle")
        return action
    }

    func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
        var object = objects[indexPath.row]
        let action = UIContextualAction(style: .normal, title: "Favourite") {
            (action, view, completion) in
            object.isFavourite = !object.isFavourite
            self.objects[indexPath.row] = object
            completion(true)
        }
        action.backgroundColor = object.isFavourite ? .systemPurple : .systemGray
        action.image = UIImage(systemName: "seal")
        return action
    }

}
