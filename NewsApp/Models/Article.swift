//
//  Article.swift
//  NewsApp
//
//  Created by Anthony Baucal on 24/09/2024.
//

import Foundation

struct Article : Identifiable, Decodable{
    var id: String? = UUID().uuidString
    let author : String?
    let title : String?
    let url : String?
    let description: String?
    let urlToImage : String?
    let publishedAt : String?
    let content : String?
    
    private enum CodingKeys: String, CodingKey {
        case author
        case title
        case url
        case description
        case urlToImage
        case publishedAt
        case content
    }

}
