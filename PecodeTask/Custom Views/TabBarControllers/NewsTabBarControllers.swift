//
//  NewsTabBarControllers.swift
//  PecodeTask
//
//  Created by Эдип on 21.01.2022.
//

import UIKit

class NewsTabBarControllers: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
    }
    
    
    func configureTabBar() {
        viewControllers = [createNewsNC(), createFavoritesNC()]
        UITabBar.appearance().tintColor = .black
        let appearance = UITabBarItem.appearance()
        let attributes: [NSAttributedString.Key: AnyObject] = [NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue): UIFont.systemFont(ofSize: 14)]
        appearance.setTitleTextAttributes(attributes, for: .normal)
    }
    
    
    func createNewsNC() -> UINavigationController {
        let searchVC = NewsListVC()
        searchVC.tabBarItem = UITabBarItem(title: "News", image: UIImage(systemName: "newspaper"), tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }
    
    
    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = NewsFavoritesVC()
        favoritesVC.title = "Favourites News"
        favoritesVC.tabBarItem = UITabBarItem(title: "Saved", image: UIImage(systemName: "bookmark"), tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
}
