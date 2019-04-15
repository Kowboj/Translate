//
//  Foundation.URLComponents.swift
//  MusicalBoom
//
//  Created by mac on 24.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

extension URLComponents {
    init(request: APIRequest) {
        self = {
            var components = URLComponents()
            components.path = request.path
            components.host = request.service.host
            components.scheme = request.service.scheme.rawValue
            components.queryItems = request.serializeToQuery()
            return components
        }()
    }
}
