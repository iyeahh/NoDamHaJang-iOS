//
//  ViewModelType.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/22/24.
//

import SwiftUI
import Combine

protocol ViewModelType: AnyObject, ObservableObject {
    associatedtype Input
    associatedtype Output

    var cancellables: Set<AnyCancellable> { get set }

    var input: Input { get set }
    var output: Output { get set }

    func transform()
}
