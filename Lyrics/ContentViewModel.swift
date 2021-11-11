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
}

class ContentViewModel: NSObject, ObservableObject {
    
    @Published var shazamMedia = ShazamMedia(title: "Title...",
                                             subtitle: "Subtitle...",
                                             artistName: "Artist Name...",
                                             albumArtURL: URL(string: "https://wwww.google.com"),
                                             genres: ["pop"],
                                             lyrics: "No lyrics found")
    @Published var isRecording = false
    
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
}

extension ContentViewModel: SHSessionDelegate {
    
    func session(_ session: SHSession, didFind match: SHMatch) {
        stopListening()
        let mediaItems = match.mediaItems
        if let firstItem = mediaItems.first {
            var lyrics = "No lyrics found"
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
                                              lyrics: lyrics)
                
                DispatchQueue.main.async {
                    self.shazamMedia = shazamMedia
                }
            }
        }
    }
    
    func session(_ session: SHSession, didNotFindMatchFor signature: SHSignature, error: Error?) {
        stopListening()
    }
}
