//
//  ListNewsItemItem.swift
//  NewsApp
//
//  Created by Anthony Baucal on 26/09/2024.
//

import SwiftUI

struct ListNewsItemItem: View {
    
    let article : Article
    

    
    var body: some View {
        
        NavigationLink(destination: ArticleView(article: article)) {
            HStack {
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                        .frame(width: 100, height: 100)

                }.cornerRadius(20)
                
                VStack(alignment: .leading) {
                    Text(article.title ?? "Titre inconnu")
                        .font(.headline)
                        .lineLimit(1)
                    
                    Text(article.description ?? "Description inconnue")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(2)
                }
                .padding()
            }
        }
    }
}

#Preview {
    let article = Article(
         author  : "test",
         title  : "test",
         url  : "test",
         description : "test",
         urlToImage  : "test",
         publishedAt  : "test",
         content  : "test"
    )
    
    ListNewsItemItem(article: article)
}
