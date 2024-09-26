//
//  SwiftUIView.swift
//  NewsApp
//
//  Created by Anthony Baucal on 24/09/2024.
//
import SwiftUI

struct ArticleView: View {

    var article: Article
    
    var body: some View {
        ScrollView {
            VStack {
                
                AsyncImage(url: URL(string: article.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        
                } placeholder: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                        .foregroundColor(.gray)
                }

                
                VStack(alignment: .leading, spacing: 10) {
                    Text(article.title ?? "Titre inconnu")
                        .font(.headline)
                        .multilineTextAlignment(.leading)
                        .padding(.top)

                    Text(article.description ?? "Description non disponible")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.leading)
                        

                    
                    if let articleUrl = article.url, let url = URL(string: articleUrl) {
                        Link("Lire l'article complet", destination: url)
                            .font(.footnote)
                            .padding(.top, 10)
                            .foregroundColor(.blue)
                    }

                    Text("Publié le : \(String(describing: article.publishedAt!))")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.top, 5)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .navigationTitle("\(article.title?.prefix(20) ?? "Titre inconnu") ...")
            .navigationBarTitleDisplayMode(.inline)
            
        }
    }
    

}

#Preview {
    ArticleView(article: Article(
        id: UUID().uuidString,
        author: "moi",
        title: "mon titre",
        url: "https://securityaffairs.com/wp-content/uploads/2024/09/image-29.png",
        description: "ma description",
        urlToImage: "https://securityaffairs.com/wp-content/uploads/2024/09/image-29.png",
        publishedAt: "2024-09-24T14:39:43Z",
        content: "mon contenu"
        )
    )
}
