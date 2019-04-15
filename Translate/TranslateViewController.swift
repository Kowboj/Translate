//
//  ViewController.swift
//  Translate
//
//  Created by Kamil Chołyk on 15/04/2019.
//  Copyright © 2019 kowboj. All rights reserved.
//

import UIKit

final class TranslateViewController: UIViewController {
    
    private let translateView = TranslateView()
    private let apiClient = DefaultAPIClient()
    
    override func loadView() {
        view = translateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        translateView.translateButton.addTarget(self, action: #selector(translate), for: .touchUpInside)
    }
    
    @objc private func translate() {
        sendTranslateRequest(text: translateView.searchTextField.text ?? "") { [weak self] (translatedStrings) in
            DispatchQueue.main.async {
                self?.translateView.resultLabel.text = translatedStrings.first ?? ""
            }
        }
    }
    
    private func sendTranslateRequest(text: String, completion: @escaping ([String]) -> Void) {
        
        apiClient.send(request: TranslateRequest(text: text)) { (response) in
            switch response {
            case .success(let data):
                do {
                    let model = try JSONDecoder().decode(TranslateResponse.self, from: data)
                    completion(model.text)
                } catch let jsonErr {
                    completion([jsonErr.localizedDescription])
                }
            case .failure(let error):
                completion([error.localizedDescription])
            }
        }
    }
}
