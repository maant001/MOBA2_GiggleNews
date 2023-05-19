//
//  ContentView.swift
//  MOBA2_GiggleNews
//
//  Created by Tony Mamaril on 13.05.23.
//

import SwiftUI


// views

struct ContentView: View {
    @State private var jokes: [Joke] = []
    @State private var selectedJoke: Joke?
    @State private var selection = "general"
    @State private var types: [String] = []


    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Text("Welcome to GIGGLE NEWS :) LMAO!").bold()
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                            
                        ForEach(types, id: \.self) { type in                                        NavigationLink(destination: JokesView(type: type),
                            label: {
                                Text(type)
                            })
                            .padding()
                    }
                }
                Spacer()
            }
            .navigationBarTitle("GIGGLE NEWS", displayMode: .inline)
        }
        .onAppear(perform: {
            loadCategories()
        })
    }
    
    func loadCategories() {
            let urlString = "https://joke.deno.dev/type"
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                do {
                    let categories = try JSONDecoder().decode([String].self, from: data)
                    DispatchQueue.main.async {
                        self.types = categories
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            task.resume()
        }
    }

struct JokesView: View {
    let type: String
    @State private var jokes: [Joke] = []
    @State private var selectedJoke: Joke?

    var body: some View {
        List(jokes) { joke in
            NavigationLink(destination: DetailView(joke: joke), tag: joke, selection: $selectedJoke) {
                Text(joke.setup)
            }
        }
        .onAppear(perform: {
            loadJokes(withParam: type)
        })
        .navigationBarTitle(type.capitalized)
    }

    func loadJokes(withParam param: String) {
        let urlString = "https://joke.deno.dev/type/\(param)"
        print(urlString)
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let jokes = try JSONDecoder().decode([Joke].self, from: data)
                DispatchQueue.main.async {
                    self.jokes = jokes
                }
            } catch {
                print(error.localizedDescription)
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
                .font(.system(size: 23))
                .foregroundColor(.red)
        }
        .padding()
        .navigationTitle("Joke")
    }
}

struct Previews_MOBA2_GiggleNewsApp_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
    }
}


// structs

struct Joke: Codable, Identifiable, Hashable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}







