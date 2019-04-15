//
//  TranslateResponse.swift
//  Translate
//
//  Created by Kamil Chołyk on 15/04/2019.
//  Copyright © 2019 kowboj. All rights reserved.
//

struct TranslateResponse: Codable {
    let code: Int
    let lang: String
    let text: [String]
}
