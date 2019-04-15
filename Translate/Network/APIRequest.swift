//
//  APIRequest.swift
//  MusicalBoom
//
//  Created by mac on 24.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case GET
    case POST
}

protocol APIRequest {
    var path: String { get }
    var service: APIService { get }
    var method: HttpMethod { get }
    var query: [String: APIQueryParameter] { get }
}

extension APIRequest {
    var service: APIService { return YandexService() }
    var method: HttpMethod { return .POST }
    var query: [String: APIQueryParameter] { return [:] }
}

extension APIRequest {
    
    func serializeToQuery() -> [URLQueryItem] {
        return self.query.flatMap { serializeToQueryComponent(key: $0, value: $1) }
    }
    
    private func serializeToQueryComponent(key: String, value: APIQueryParameter) -> [URLQueryItem] {
        switch value {
        case .bool(let bool):
            return [URLQueryItem(name: key, value: bool ? "1" : "0")]
        case .double(let double):
            return [URLQueryItem(name: key, value: "\(double)")]
        case .int(let int):
            return [URLQueryItem(name: key, value: "\(int)")]
        case .string(let string):
            return [URLQueryItem(name: key, value: string)]
        }
    }
}
