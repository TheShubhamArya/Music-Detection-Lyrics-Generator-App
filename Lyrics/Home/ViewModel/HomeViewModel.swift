//
//  ContentViewModel.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/10/21.
//

import SwiftUI
import ShazamKit
import AVKit

struct ShazamMedia: Decodable {
    let title: String?
    let subtitle: String?
    let artistName : String?
    let albumArtURL: URL?
    let genres: [String]
    let lyrics: String?
    let webURL: URL?
    let shazamID : String?
}

class HomeViewModel: NSObject, ObservableObject {
    
    @Published var shazamMedia = ShazamMedia(title: "Tap Listen",
                                             subtitle: "",
                                             artistName: "Find songs, lyrics, and more",
                                             albumArtURL: URL(string: "https://wwww.google.com"),
                                             genres: [],
                                             lyrics: "",
                                             webURL: nil,
                                             shazamID: nil)
    @Published var isRecording = false
    @Published var foundNothing = true
    
    
    private var audioEngine = AVAudioEngine()
    private let session = SHSession()
    private let signatureGenerator = SHSignatureGenerator()
    
    override init() {
        super.init()
        session.delegate = self
    }
    
    public func startOrEndListening() {
        stopListening()
        let audioSession = AVAudioSession.sharedInstance()
        audioSession.requestRecordPermission { isGranted in
            guard isGranted else {return}
            try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            let inputNode = self.audioEngine.inputNode
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
                self.session.matchStreamingBuffer(buffer, at: nil)
            }
            
            self.audioEngine.prepare()
            do {
                try self.audioEngine.start()
            } catch (let error) {
                assertionFailure(error.localizedDescription)
            }
            
            DispatchQueue.main.async {
                self.isRecording = true
            }
        }
    }
    
    func stopListening() {
        guard !audioEngine.isRunning else {
            audioEngine.inputNode.removeTap(onBus: 0)
            audioEngine.stop()
            DispatchQueue.main.async {
                self.isRecording = false
            }
            return
        }
    }
    
    func setDefaultValuesForMusicNotFound() {
        DispatchQueue.main.async {
            self.foundNothing = true
            self.shazamMedia = ShazamMedia(title: "Could not find music.",
                                           subtitle: "",
                                           artistName: "",
                                           albumArtURL: URL(string: "https://wwww.google.com"),
                                           genres: [],
                                           lyrics: "",
                                           webURL: nil,
                                           shazamID: nil)
        }
    }
    
    
    
    func listenTapped() {
        isRecording = !isRecording
        if !isRecording {
            stopListening()
        } else {
            startOrEndListening()
        }
    }
}

extension HomeViewModel: SHSessionDelegate {
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        stopListening()
        DispatchQueue.main.async {
            self.foundNothing = false
        }
        let mediaItems = match.mediaItems
        if let firstItem = mediaItems.first {
            var lyrics : String = ""
            let songDetails = LyricsAPI(artist: firstItem.artist?.mainArtistName ?? "",
                                   song: firstItem.title ?? "")
            songDetails.fetchLyrics { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let song):
                    lyrics = song.lyrics.cleanedLyrics
                }
                
                let shazamMedia = ShazamMedia(title: firstItem.title,
                                              subtitle: firstItem.subtitle,
                                              artistName: firstItem.artist,
                                              albumArtURL: firstItem.artworkURL,
                                              genres: firstItem.genres,
                                              lyrics: lyrics,
                                              webURL: firstItem.webURL,
                                              shazamID: firstItem.shazamID)
                
                DispatchQueue.main.async {
                    self.shazamMedia = shazamMedia
                }
            }
        } else {
            print("nothing found")
        }
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        setDefaultValuesForMusicNotFound()
        stopListening()
    }
}
