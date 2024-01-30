//
//  String+.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import Foundation

extension String {
    func removeSlash() -> Self {
        return self.components(separatedBy: ["\\"]).joined()
    }
}
