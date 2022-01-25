//
//  NewsFavoritesVC.swift
//  PecodeTask
//
//  Created by Эдип on 21.01.2022.
//

import UIKit
import CoreData

class NewsFavoritesVC: UIViewController {
   
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let tableView = UITableView()
    var favorites: [News] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureTableView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(NewsFavoritesCell.self, forCellReuseIdentifier: NewsFavoritesCell.identifier)
    }
    
    
    func loadData() {
        let request: NSFetchRequest<News> = News.fetchRequest()
        
        do {
            favorites = try context.fetch(request)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch {
            print("Empty: \(error)")
        }
    }
}


extension NewsFavoritesVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsFavoritesCell.identifier, for: indexPath) as? NewsFavoritesCell else {
            fatalError()
        }
        let favorite = favorites[indexPath.row]
        cell.set(with: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "Delete") { action, view, completionHandler in

            let items = self.favorites[indexPath.row]
            
            self.context.delete(items)
            do {
                try self.context.save()
            } catch  {
                print("Saving Error: \(error)")
            }
            self.loadData()
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
}
