//
//  ContentView.swift
//  MOBA2_GiggleNews
//
//  Created by Tony Mamaril on 13.05.23.
//

import SwiftUI


// views

struct ContentView: View {
    var body: some View {
        //TODO
    }
}



struct JokePunchlineView : View {
    var id : Int
    @State var joke : Joke
    
    var body : some View {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// structs

struct Joke: Identifiable, Decodable {
    var setup : String?
    var punchline : String?
    var id: Int?
}

struct JokeWrapper: Decodable {
    // TODO not sure if correct/needed
    var results : [Joke]
}
