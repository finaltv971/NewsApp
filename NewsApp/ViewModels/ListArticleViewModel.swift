//
//  ArticleViewModel.swift
//  NewsApp
//
//  Created by Anthony Baucal on 24/09/2024.
//
import Foundation


class ListArticleViewModel : ObservableObject{
    
    @Published var loaded : Bool = false
    @Published var error : Bool = false
    @Published var errorMessage : Error?
    @Published var articles : [Article]? = []
    
    let url : String = "http://192.168.1.25:3000/news.json"
    
    
    public func getArticles() {
        fetchJsonData(url: url) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let articles):
                    self?.articles = articles
                    self?.loaded = true
                    print("Articles chargés : \(articles.count)")
                case .failure(let error):
                    self?.error = true
                    self?.errorMessage = error
                    print("Erreur lors du chargement des articles : \(error)")
                }
            }
        }
    }

    
}
