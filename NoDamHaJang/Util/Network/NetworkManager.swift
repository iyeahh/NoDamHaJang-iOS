//
//  NetworkManager.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import UIKit
import Alamofire

enum NetworkError: Error {
    case unstableStatus
    case invaildURL
    case unknownResponse
}

final class NetworkManager: RequestInterceptor {

    static let shared = NetworkManager()

    private init() { }

    func callRequest<T: Decodable>(router: Router, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var request: URLRequest

        guard NetworkMonitor.shared.isConnected else {
            completion(.failure(.unstableStatus))
            return
        }

        do {
            request = try router.asURLRequest()
        } catch {
            completion(.failure(.invaildURL))
            return
        }

        AF.request(request)
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let value):
                    completion(.success(value))
                case .failure:
                    completion(.failure(.unknownResponse))
                }
            }
    }
}
