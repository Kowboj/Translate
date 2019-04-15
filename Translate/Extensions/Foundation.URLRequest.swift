//
//  Foundation.URLRequest.swift
//  MusicalBoom
//
//  Created by mac on 24.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

extension URLRequest {
    init(request: APIRequest) throws {
        guard let url = URLComponents(request: request).url else { throw APIError.incorrectURL(url: request.path) }
        self.init(url: url)
        self.httpMethod = request.method.rawValue
    }
}
