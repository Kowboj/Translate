//
//  APIService.swift
//  MusicalBoom
//
//  Created by mac on 24.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

enum Scheme: String {
    case http
    case https
}

protocol APIService {
    var scheme: Scheme { get }
    var host: String { get }
}

extension APIService {
    var scheme: Scheme { return .https }
}
