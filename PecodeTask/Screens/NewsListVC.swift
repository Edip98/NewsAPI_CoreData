//
//  NewsListVC.swift
//  PecodeTask
//
//  Created by Эдип on 20.01.2022.
//

import UIKit
import WebKit

class NewsListVC: UIViewController {
    
    let tableView = UITableView()
    let seartchVC = UISearchController()
    let spinner = UIActivityIndicatorView()
    
    var articles = [Article]()
    var viewModels = [NewsCellModel]()
    // !!!Note: you can't mix sources param with the country or category params!!!
    var sources = ""
    var category = "technology"
    var country = "ua"
    var page = 1
    var hasMoreNews = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        fetchNews()
        createSpinner()
        createSearchBar()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.identifier)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    
    @objc func didPullToRefresh() {
        refreshNews()
        spinner.stopAnimating()
    }
    
    
    func refreshNews() {
        NetworkManager.shared.fetchNews(sources: sources, category: category, country: country, page: page) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles.removeAll()
                self?.viewModels.removeAll()
                if articles.count < 10 { self?.hasMoreNews = false }
                self?.articles.append(contentsOf: articles)
                self?.viewModels.append(contentsOf: articles.compactMap({ NewsCellModel(source: $0.source.name ?? "No Source", author: $0.author ?? "No Author", title: $0.title ?? "No Title", subtitle: $0.description ?? "No Description", imageURL: URL(string: $0.urlToImage ?? ""))
                }))
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.tableView.tableFooterView = nil
                    self?.spinner.stopAnimating()
                    self?.tableView.refreshControl?.endRefreshing()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func createSearchBar() {
        navigationItem.searchController = seartchVC
        seartchVC.searchBar.delegate = self
    }
    
    
    func createSpinner() {
        spinner.center = view.center
        view.addSubview(spinner)
    }
    
    
    func fetchNews() {
        spinner.startAnimating()
        NetworkManager.shared.fetchNews(sources: sources, category: category, country: country, page: page) { [weak self] result in
            switch result {
            case .success(let articles):
                if articles.count < 10 { self?.hasMoreNews = false }
                self?.articles.append(contentsOf: articles)
                self?.viewModels.append(contentsOf: articles.compactMap({ NewsCellModel(source: $0.source.name ?? "No Source", author: $0.author ?? "No Author", title: $0.title ?? "No Title", subtitle: $0.description ?? "No Description", imageURL: URL(string: $0.urlToImage ?? ""))
                }))
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.spinner.stopAnimating()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSettY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offSettY > contentHeight - height {
            guard hasMoreNews else { return }
            page += 1
            self.tableView.tableFooterView = createSpinnerFooter()
            fetchNews()
            spinner.stopAnimating()
        }
    }
    
    
     func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 160))
        let spinner = UIActivityIndicatorView()
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
}


extension NewsListVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.identifier, for: indexPath) as? NewsCell else { fatalError() }
        let favorite = viewModels[indexPath.row]
        cell.set(with: favorite)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let article = articles[indexPath.row]
        
        guard let url = URL(string: article.url ?? "") else { return }
        
        let vc = WebViewVC(url: url)
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}


extension NewsListVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty  else { return }
        NetworkManager.shared.search(sources: sources, category: category, country: country, page: page, query: text) { [weak self] result in
            switch result {
            case .success(let articles):
                self?.articles = articles
                self?.viewModels = articles.compactMap({ NewsCellModel(source: $0.source.name ?? "No Source", author: $0.author ?? "No Author", title: $0.title ?? "No Title", subtitle: $0.description ?? "No Description", imageURL: URL(string: $0.urlToImage ?? ""))
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.seartchVC.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        articles = []
        viewModels = []
        refreshNews()
    }
}
