//
//  LyricsAPI.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/10/21.
//

import Foundation

struct SongDetails: Decodable, Hashable {
    let lyrics: String
}

enum ErrorStatus : Error {
    case noDataAvailable
    case cannotProcessdata
}

struct LyricsAPI {
    
    var resourceURL : URL
    var url = "https://api.lyrics.ovh/v1/"
    var artist : String
    var song : String
    
    init(artist: String, song: String){
        self.song = song
        self.artist = artist
        let completeURL = url + artist + "/" + song
        print(completeURL)
        if let resourceURL = URL(string: completeURL) {
            self.resourceURL = resourceURL
        } else {
            self.resourceURL = completeURL.getCleanedURL()!
        }
    }
    
    func fetchLyrics(completion: @escaping(Result<SongDetails, ErrorStatus>)->Void) {
        let dataTask = URLSession.shared.dataTask(with: resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let reponse = try decoder.decode(SongDetails.self, from: jsonData)
                completion(.success(reponse))
                
            } catch {
                completion(.failure(.cannotProcessdata))
            }
        }
        dataTask.resume()
    }
}
