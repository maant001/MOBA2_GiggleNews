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
    let data = ["general","knock-knock","programming"]
    let data2 = ["anime","food","dad"]
    
    var body: some View {
        VStack {
            Text("Welcome to GIGGLE NEWS :) LMAO!").bold()
            
            // Display buttons for each type of joke
            HStack {
                ForEach(data, id: \.self) { type in
                    Button(type) {
                        selection = type
                        loadJokes(withParam: type)
                    }
                    .padding()
                }
            }
            
            HStack {
                ForEach(data2, id: \.self) { type in
                    Button(type) {
                        selection = type
                        loadJokes(withParam: type)
                    }
                    .padding()
                }
            }
            
            Spacer()
            
            NavigationView {
                List(jokes) { joke in
                    NavigationLink(destination: DetailView(joke: joke), tag: joke, selection: $selectedJoke) {
                        Text(joke.setup)
                    }
                }
                .onAppear(perform: {
                    loadJokes(withParam: selection)
                })
            }
        }
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
                //.font(.subheadline)
                .font(.system(size: 23))
                .foregroundColor(.red)

               
        }
        .padding()
        //.navigationTitle("Joke")
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







