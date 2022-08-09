//
//  ContentView.swift
//  Movies
//
//  Created by John Pill on 08/08/2022.
//

import SwiftUI

struct Quote: Codable {
    var quote_id: Int
    var quote: String
    var author: String
    var series: String
}

struct QuoteView: View {
    @State private var quotes = [Quote]()
    
    var body: some View {
        
        NavigationView {
            List(quotes, id: \.quote_id) { quote in
                
                VStack(alignment: .leading) {
                    Text(quote.author)
                        .font(.headline)
                    Text(quote.quote)
                        .font(.body)
                }
            }
            .navigationTitle("Quotes")
            .task{ await fetchData() }
        }
    }
    
    func fetchData() async {
        // Create URL
        guard let url = URL(string: "https://www.breakingbadapi.com/api/quotes") else {
            print("Hey the URL went wrong!")
            return
        }
        
        // Fetch data from URL
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode data
            if let decodedResponse = try? JSONDecoder().decode([Quote].self, from: data) {
                quotes = decodedResponse
            }
        } catch {
            print("Data isn't valid")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}
