//
//  StringExtensions.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/11/21.
//

import Foundation

extension String {
    func getCleanedURL() -> URL? {
        guard self.isEmpty == false else {
            return nil
        }
        if let url = URL(string: self) {
            return url
        } else {
            if let urlEscapedString = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) , let escapedURL = URL(string: urlEscapedString){
                return escapedURL
            }
        }
        return nil
    }
    
    var cleanedLyrics : String {
        var lyricsModifier = self
        if self.contains("Paroles de la chanson ") {
            if let index = self.index(of: "\r\n") {
                let substring = lyricsModifier[..<index]
                lyricsModifier = self.replacingOccurrences(of: substring, with: "")
            }
        }
        return lyricsModifier
    }
    
    var mainArtistName : String {
        if self.contains("Feat") {
            return getMainName(completeString: self, removePart: "Feat")
        } else if self.contains("&") {
            return getMainName(completeString: self, removePart: "&")
        } else if self.contains(",") {
            return getMainName(completeString: self, removePart: ",")
        }
        return self
    }
    
    func getMainName(completeString: String, removePart: String) -> String{
        if let index = self.index(of: removePart) {
            let substring = completeString[..<index]
            return String(substring)
        }
        return completeString
    }
}

extension StringProtocol {
    func index<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.lowerBound
    }
    func endIndex<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> Index? {
        range(of: string, options: options)?.upperBound
    }
    func indices<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Index] {
        ranges(of: string, options: options).map(\.lowerBound)
    }
    func ranges<S: StringProtocol>(of string: S, options: String.CompareOptions = []) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var startIndex = self.startIndex
        while startIndex < endIndex,
            let range = self[startIndex...]
                .range(of: string, options: options) {
                result.append(range)
                startIndex = range.lowerBound < range.upperBound ? range.upperBound :
                    index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return result
    }
}
