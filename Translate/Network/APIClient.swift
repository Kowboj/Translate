//
//  APIClient.swift
//  MusicalBoom
//
//  Created by mac on 24.02.2018.
//  Copyright © 2018 Kamil Chołyk. All rights reserved.
//

import Foundation

protocol APIClient {
    func send(request: APIRequest, completion: @escaping (Result<Data>) -> ())
}
