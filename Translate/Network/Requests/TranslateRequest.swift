//
//  SearchRequest.swift
//  MusicalBoom
//
//  Created by mac on 24.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

struct TranslateRequest: APIRequest {
    
    private let text: String
    private let token = "trnsl.1.1.20190415T175701Z.6b758ac9d92eb1be.833b531abfc6c0a899a5149a9c48e5dcd28c653a"
    
    init(text: String) {
        self.text = text
    }
    var path: String { return "/api/v1.5/tr.json/translate" }
    var query: [String : APIQueryParameter] {
        return ["key" : .string(token),
                "text" : .string(text),
                "lang" : .string("pl-en")
        ]
    }
}

