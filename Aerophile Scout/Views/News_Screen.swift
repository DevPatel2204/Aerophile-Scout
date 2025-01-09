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
    let link: String
}
struct News_Screen: View {
    @State private var newsList: [News]
    @State private var isLoading: Bool

    init(newsList: [News] = [], isLoading: Bool = true) {
        _newsList = State(initialValue: newsList)
        _isLoading = State(initialValue: isLoading)
    }

    var body: some View {
        NavigationView {
            List(newsList) { news in
                VStack(alignment: .leading) {
                    Text(news.title)
                        .font(.headline)
                    Link("Read more", destination: URL(string: news.link)!)
                        .foregroundColor(.blue)
                }
                .padding(.vertical, 5)
            }
            .navigationTitle("Aviation News")
            .onAppear(perform: fetchNews)
            .overlay(
                Group {
                    if isLoading {
                        ProgressView("Loading...")
                    }
                }
            )
        }
    }

    private func fetchNews() {
        guard let url = URL(string: "https://www.flightglobal.com/news/aerospace") else {
            print("Invalid URL")
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }

            do {
                let html = String(data: data, encoding: .utf8) ?? ""
                let document = try SwiftSoup.parse(html)
                let articles = try document.select(".article-link") // Adjust selector based on the website's structure
                var fetchedNews: [News] = []

                for article in articles {
                    let title = try article.text()
                    let link = try article.attr("href")
                    fetchedNews.append(News(title: title, link: link))
                }

                DispatchQueue.main.async {
                    self.newsList = fetchedNews
                    self.isLoading = false
                }
            } catch {
                print("Error parsing HTML: \(error.localizedDescription)")
            }
        }.resume()
    }
}

#Preview {
    News_Screen(newsList: [News(title: "Sample News", link: "https://example.com")], isLoading: false)
}

