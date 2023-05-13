//
//  ContentView.swift
//  MOBA2_GiggleNews
//
//  Created by Tony Mamaril on 13.05.23.
//

import SwiftUI


// views

struct ContentView: View {
    @State var jokeSetupList = [Joke] ()
    
    var body: some View {
        //TODO
        VStack{
            
            // TODO BEAUTIFY
            Text(String("Welcome to GIGGLE NEWS :) LMAO!")).bold()

            
            //TODO implement later
            NavigationView {
                List(jokeSetupList) {
                    joke in

                    // TODO ! ?
                    NavigationLink(destination: JokePunchlineView(id: joke.id!, joke: Jsonhelpers.loadOneJoke(jokeId: joke.id!))) {
                        Text(joke.setup!).frame(maxWidth: .infinity, alignment: .center).bold()
                    }
                }.onAppear() {
                    DispatchQueue.main.async {
                        // TODO crashes after next line
                        //self.jokeSetupList = Jsonhelpers.loadJokes()
                    }
                }

            }
        }
    }
}



struct JokePunchlineView : View {
    var id : Int
    @State var joke : Joke
    
    var body : some View {
        
        VStack(alignment: .center) {
            
            Text(joke.setup!).bold()
            Spacer()
            Text(joke.punchline!)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// structs

struct Joke: Identifiable, Decodable {
    var jokeId: Int?
    var setup : String?
    var punchline : String?
    var type : String?
    var id: Int? {
        get {
            return jokeId ?? 0
        }
    }
}

struct JokeWrapper: Decodable {
    var results : [Joke]
}
