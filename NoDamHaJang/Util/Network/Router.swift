//
//  Router.swift
//  NoDamHaJang
//
//  Created by Bora Yang on 9/26/24.
//

import Foundation
import Alamofire

enum Router {
    case fetchNews(index: Int)
}

extension Router: TargetType {
    var method: Alamofire.HTTPMethod {
        switch self {
        case .fetchNews:
            return .get
        }
    }

    var parameters: String? {
        return nil
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .fetchNews(let index):
            return [URLQueryItem(name: "query", value: "금연"),
                    URLQueryItem(name: "start", value: "\(index)")]
        }
    }

    var body: Data? {
        return nil
    }

    var baseURL: String {
        switch self {
        case .fetchNews:
            return APIKey.baseURL + "/v1"
        }
    }

    var path: String {
        switch self {
        case .fetchNews:
            return "/search/news.json"
        }
    }

    var header: [String: String] {
        switch self {
        case .fetchNews:
            return [
                Header.clientID.rawValue: APIKey.clientId,
                Header.clientSceret.rawValue: APIKey.clientSecret
            ]
        }
    }
}
