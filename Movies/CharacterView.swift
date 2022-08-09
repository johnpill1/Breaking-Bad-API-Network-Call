//
//  Characters.swift
//  Movies
//
//  Created by John Pill on 08/08/2022.
//

import SwiftUI


struct Chars: Codable {
    var char_id: Int
    var name: String
    var img: String
    var portrayed: String
}


struct CharacterView: View {
    @State private var characters = [Chars]()
    
    var body: some View {
           
            NavigationView {
                List(characters, id: \.char_id) { char in
                    
                   
                    HStack {
                        AsyncImage(url: URL(string: char.img)) { image in
                            image
                                .resizable()
                                .clipShape(Circle())
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                            .frame(width: 75, height: 75)
                        VStack(alignment: .leading) {
                                Text(char.name)
                                    .font(.headline)
                                Text(char.portrayed)
                                    .font(.body)
                            
                        }
                    }
                }
                .listStyle(GroupedListStyle())
                .navigationTitle("Characters")
                .task   {
                        await fetchData2()
                        }
                
        }
    }
        
        func fetchData2() async {
            // Create URL
            guard let url = URL(string: "https://www.breakingbadapi.com/api/characters") else {
                print("Hey the URL went wrong!")
                return
            }
            
            // Fetch data from URL
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                
                // Decode data
                if let decodedResponse = try? JSONDecoder().decode([Chars].self, from: data) {
                    characters = decodedResponse
                }
            } catch {
                print("Data isn't valid")
            }
            
            
            
        }
    }


struct Characters_Previews: PreviewProvider {
    static var previews: some View {
        CharacterView()
    }
}
