//
//  News_View.swift
//  Aerophile Scout
//
//  Created by Dev on 28/12/24.
//

import SwiftUI
import SwiftSoup

struct News: Identifiable {
    let id = UUID()
    let title: String
    let description: String
    let link: String
    let imageUrl: String?
}

struct News_Screen: View {
    @State private var newsList: [News] = []
    @State private var isLoading = true
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.cyan]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                if isLoading {
                    ProgressView("Fetching latest news...")
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        .foregroundColor(.white)
                } else if let error = errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.yellow)
                        Text(error)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                        Button("Retry") {
                            fetchNews()
                        }
                        .buttonStyle(.bordered)
                        .tint(.white)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(newsList) { news in
                                NewsCard(news: news)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Aviation News")
            .onAppear(perform: fetchNews)
        }
    }
    
    private func fetchNews() {
        isLoading = true
        errorMessage = nil
        
        // Using Simple Flying as the source
        guard let url = URL(string: "https://simpleflying.com/category/aviation-news/") else {
            errorMessage = "Invalid URL"
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    errorMessage = "Failed to load news: \(error.localizedDescription)"
                    isLoading = false
                }
                return
            }
            
            guard let data = data,
                  let html = String(data: data, encoding: .utf8) else {
                DispatchQueue.main.async {
                    errorMessage = "Failed to parse website data"
                    isLoading = false
                }
                return
            }
            
            do {
                let doc = try SwiftSoup.parse(html)
                let articles = try doc.select("article")
                var newsItems: [News] = []
                
                for article in articles {
                    let title = try article.select("h3").text()
                    let description = try article.select("p.excerpt").text()
                    let link = try article.select("a").attr("href")
                    let imageUrl = try? article.select("img").attr("src")
                    
                    let news = News(title: title,
                                  description: description,
                                  link: link,
                                  imageUrl: imageUrl)
                    newsItems.append(news)
                }
                
                DispatchQueue.main.async {
                    self.newsList = newsItems
                    self.isLoading = false
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Failed to parse news content"
                    isLoading = false
                }
            }
        }.resume()
    }
}

struct NewsCard: View {
    let news: News
    
    var body: some View {
        Link(destination: URL(string: news.link) ?? URL(string: "https://simpleflying.com")!) {
            VStack(alignment: .leading, spacing: 8) {
                if let imageUrl = news.imageUrl,
                   let url = URL(string: imageUrl) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    }
                    .frame(height: 200)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                
                Text(news.title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(2)
                
                Text(news.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                
                HStack {
                    Text("Read more")
                        .font(.caption)
                        .foregroundColor(.blue)
                    
                    Spacer()
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(.systemBackground))
                    .shadow(color: .black.opacity(0.2), radius: 5)
            )
        }
    }
}

#Preview {
    News_Screen()
}

