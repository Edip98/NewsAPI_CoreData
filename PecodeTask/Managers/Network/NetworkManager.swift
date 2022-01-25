//
//  NetworkManager.swift
//  PecodeTask
//
//  Created by Эдип on 23.01.2022.
//

import Foundation

import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    let newsURL = "https://newsapi.org"
    
    
    public func fetchNews(sources: String, category: String, country: String, page: Int, completion: @escaping (Result<[Article], RequestError>) -> Void) {
        // !!! Note: you can't mix sources param with the country or category params !!!
        // sortBy default: publishedAt
        let endpoint = newsURL + "/v2/top-headlines?sources=\(sources)&category=\(category)&country=\(country)&pageSize=20&page=\(page)&apiKey=ca2c90d0dd324e95b470e1156c41a904"
        
        guard let url = URL(string: endpoint) else { completion(.failure(.invalidRequestParameters))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
     
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                } catch  {
                    completion(.failure(.invalidData))
                }
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
        }
        task.resume()
    }
    
    
    public func search(sources: String, category: String, country: String, page: Int, query: String, completion: @escaping (Result<[Article], RequestError>) -> Void) {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let urlString = newsURL + "/v2/top-headlines?sources=\(sources)&category=\(category)&country=\(country)&apiKey=cd2273a91d5a4e828c4e85db242a34ec&q=" + query
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.articles))
                } catch  {
                    completion(.failure(.invalidData))
                }
            }
        }
        task.resume()
    }
}
