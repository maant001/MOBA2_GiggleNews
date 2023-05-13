//
//  jsonhelpers.swift
//  MOBA2_GiggleNews
//
//  Created by Tony Mamaril on 13.05.23.
//

import Foundation

class Jsonhelpers {
    // helpers

    class func loadJokeSetups() -> [Joke] {
        do {
            let urlString = "https://official-joke-api.appspot.com/random_ten"
            let urlEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlFinal = URL(string: urlEncoded)!
            let data = try Data(contentsOf: urlFinal)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(JokeWrapper.self, from: data)
            
            return decodedData.results.filter({
                return $0.setup != nil
            })
        } catch {
            fatalError("json not loaded\n\(error)")
        }
    }

//    class func loadJokePunchLine(collectionId: Int) -> [Song] {
//        do {
//            let urlString = "https://itunes.apple.com/lookup?id=" + String(collectionId) + "&entity=song"
//
//            print(urlString)
//
//            let urlEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
//            let urlFinal = URL(string: urlEncoded)!
//            let data = try Data(contentsOf: urlFinal)
//            let decoder = JSONDecoder()
//            let decodedData = try decoder.decode(SongWrapper.self, from: data)
//
//            print(decodedData)
//
//            // TODO careful with filter here!!!
//            return decodedData.results.filter({
//                return $0.wrapperType != "collection"
//            })
//        } catch {
//            fatalError("json not loaded\n\(error)")
//        }
//    }

    class func loadOneJoke(jokeId: Int) -> Joke {
        do {
            let urlString = "https://official-joke-api.appspot.com/jokes/" + String(jokeId)
            
            print(urlString)

            
            let urlEncoded = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let urlFinal = URL(string: urlEncoded)!
            let data = try Data(contentsOf: urlFinal)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode(JokeWrapper.self, from: data)
            
            return decodedData.results.filter({
                return $0.punchline != nil
            })[0]
        } catch {
            fatalError("json not loaded\n\(error)")
        }
    }
    
}
