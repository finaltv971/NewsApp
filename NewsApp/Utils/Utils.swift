//
//  Utils.swift
//  NewsApp
//
//  Created by Anthony Baucal on 24/09/2024.
//

import Foundation

func fetchJsonData(url : String,completion: @escaping (Result<[Article], Error>) ->Void){
    
    guard let urlObj = URL(string: url) else{
        fatalError()
    }
    
    let request = URLRequest(url:urlObj)
    
    let tache = URLSession.shared.dataTask(with: request) { (data, response, error) in

        if let error = error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
            return
        }
        
        guard let responseHttp = response as? HTTPURLResponse else {
            DispatchQueue.main.async {
                completion(.failure(NSError(domain: "", code: 404)))
            }
            return
        }
        
        if (200...299).contains(responseHttp.statusCode) {
            guard let data = data else {return}
            
            do{
                print("decodage en cours")
                if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],

                    let articlesArray = jsonObject["articles"] as? [[String: Any]] {
                    
                    let articlesData = try JSONSerialization.data(withJSONObject: articlesArray, options: [])
                    
                    let decodedArticles = try JSONDecoder().decode([Article].self, from: articlesData)
                    
                    print("il y a \(decodedArticles.count) articles")
                    completion(.success(decodedArticles))
                    
                } else {
                    completion(.failure(NSError(domain: "", code: 500, userInfo: [NSLocalizedDescriptionKey: "Format de JSON invalide"])))
                }
            }
            catch{
                DispatchQueue.main.async{
                    print(error)
                    completion(.failure(error))
                }
            }
        }else{
            DispatchQueue.main.async{
                completion(.failure(NSError(domain: "", code: 400, userInfo: ["error":"aucune idée"])))
            }
        }
    }
    tache.resume()
}

