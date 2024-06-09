//
//  String+.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/28/24.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    var removedString: String {
        let filteredString = self.replacingOccurrences(of: "</b>", with: "")
        return filteredString.replacingOccurrences(of: "<b>", with: "")
    }
}
