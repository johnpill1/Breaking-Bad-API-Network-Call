//
//  MoviesApp.swift
//  Movies
//
//  Created by John Pill on 08/08/2022.
//

import SwiftUI

@main
struct MoviesApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                      QuoteView()
                          .tabItem {
                              Label("Quotes", systemImage: "rectangle.3.group.bubble.left")
                          }

                      CharacterView()
                          .tabItem {
                              Label("Characters", systemImage: "person")
                          }
        }
    }
}
}
