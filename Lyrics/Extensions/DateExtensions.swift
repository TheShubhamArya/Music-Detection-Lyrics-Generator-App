//
//  DateExtensions.swift
//  Lyrics
//
//  Created by Shubham Arya on 11/15/21.
//

import Foundation

extension Date {
    var fullDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd LLLL, yyyy 'at' h:mm a"
        let nameOfMonth = dateFormatter.string(from: self)
        return nameOfMonth
    }
}
