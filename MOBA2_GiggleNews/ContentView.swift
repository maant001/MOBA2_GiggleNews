//
//  ContentView.swift
//  MOBA2_GiggleNews
//
//  Created by Tony Mamaril on 13.05.23.
//

import SwiftUI

struct ContentView: View {
    @State private var jokes: [Joke] = []
       @State private var selectedJoke: Joke?
       
       var body: some View {
           
           VStack {
               
               Text(String("Welcome to GIGGLE NEWS :) LMAO!")).bold()

               NavigationView {
                   
                   List(jokes) { joke in
                       
                       NavigationLink(destination: DetailView(joke: joke), tag: joke, selection: $selectedJoke) {
                           
                           Text(joke.setup)
                       }
                   }
                   .onAppear(perform: loadJokes)
                   //.navigationTitle("Giggle News")
               }
           }
           

       }
       
       private func loadJokes() {
           let url = URL(string: "https://official-joke-api.appspot.com/random_ten")!
           
           let task = URLSession.shared.dataTask(with: url) { data, response, error in
               guard let data = data else {
                   print("Error: \(error?.localizedDescription ?? "Unknown error")")
                   return
               }
               
               do {
                   self.jokes = try JSONDecoder().decode([Joke].self, from: data)
               } catch {
                   print("fatal error: \(error.localizedDescription)")
               }
           }
           
           task.resume()
       }
   }

   struct DetailView: View {
       let joke: Joke
       
       var body: some View {
           
           VStack(alignment: .center) {
               
               Text(joke.setup)
                   .font(.headline)
                   .padding()
               
               
               Text(joke.punchline)
                   //.font(.subheadline)
                   .foregroundColor(.red)
               
           }
           .padding()
           //.navigationTitle("Joke")
       }
   }

   struct Joke: Codable, Identifiable, Hashable {
       let id: Int
       let type: String
       let setup: String
       let punchline: String
   }

struct Previews_MOBA2_GiggleNewsApp_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}
