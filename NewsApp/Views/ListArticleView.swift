import SwiftUI

struct ListArticleView: View {
    @StateObject var listArticleViewModel = ListArticleViewModel()
    @State private var champsRechercheVisible = false
    @State private var recherche = ""
    
    var filteredArticles: [Article] {
        if let articles = listArticleViewModel.articles {
            return articles.filter { article in
                (article.title?.localizedCaseInsensitiveContains("Removed") == false) &&
                (article.title?.localizedCaseInsensitiveContains(recherche) == true || recherche.isEmpty)
            }
        }
        return [
            Article(
                author: "test",
                title: "Aucun article trouver",
                url: "test",
                description: "Aucun article trouver",
                urlToImage: "test",
                publishedAt: "test",
                content: "test"
            )
        ]
    }
    
    var body: some View {
        NavigationView {
            VStack {
                if listArticleViewModel.loaded {
                    if !filteredArticles.isEmpty {
                        List(filteredArticles) { article in
                            ListNewsItemItem(article: article)
                        }
                        .refreshable {
                            listArticleViewModel.getArticles()
                        }
                        .listStyle(PlainListStyle())
                        .searchable(text: $recherche, isPresented: $champsRechercheVisible)
                        
                    } else {
                        Text("Aucun article disponible.")
                            .padding()
                    }
                } else if listArticleViewModel.error {
                    Text("Erreur: \(listArticleViewModel.errorMessage?.localizedDescription ?? "Erreur inconnue")")
                        .padding()
                } else {
                    ProgressView("Chargement des articles...")
                }
            }.navigationTitle("News")
                .toolbarTitleDisplayMode(.inlineLarge)
                
        }
        .onAppear {
            listArticleViewModel.getArticles()
        }
    }
}

#Preview {
    ListArticleView()
}
