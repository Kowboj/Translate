//
//  ViewController.swift
//  Translate
//
//  Created by Kamil Chołyk on 15/04/2019.
//  Copyright © 2019 kowboj. All rights reserved.
//

import UIKit
import AVFoundation
import Speech

final class TranslateViewController: UIViewController {
    
    private let translateView = TranslateView()
    private let apiClient = DefaultAPIClient()
    
    private let audioEngine = AVAudioEngine()
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "pl-US"))
    private var request = SFSpeechAudioBufferRecognitionRequest()
    private var recognitionTask: SFSpeechRecognitionTask?
    private var isRecording: Bool = false
    
    override func loadView() {
        view = translateView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.videoRecording, options: [])
        self.translateView.translateButton.isEnabled = false
        translateView.translateButton.addTarget(self, action: #selector(recordAndRecognizeSpeech), for: .touchUpInside)
        requestSpeechAuthorization()
    }
    
    @objc private func translate() {
        sendTranslateRequest(text: translateView.searchTextField.text ?? "") { [weak self] (translatedStrings) in
            DispatchQueue.main.async {
                self?.translateView.resultLabel.text = translatedStrings.first ?? ""
            }
        }
    }
    
    @objc private func recordAndRecognizeSpeech() {
        if isRecording {
            translateView.translateButton.backgroundColor = .clear
            isRecording = false
            audioEngine.stop()
            audioEngine.inputNode.removeTap(onBus: 0)
        } else {
            request = SFSpeechAudioBufferRecognitionRequest()
            translateView.translateButton.backgroundColor = .red
            let node = audioEngine.inputNode
            let recordingFormat = node.outputFormat(forBus: 0)
            node.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
                self.request.append(buffer)
            }
            audioEngine.prepare()
            do {
                try audioEngine.start()
                isRecording = true
            } catch {
                return print(error)
            }
            guard let myRecognizer = SFSpeechRecognizer() else { return }
            guard myRecognizer.isAvailable else { return }
            recognitionTask = speechRecognizer?.recognitionTask(with: request, resultHandler: { [weak self] (result, error) in
                if let result = result {
                    let bestString = result.bestTranscription.formattedString
                    self?.translateView.resultLabel.text = bestString
                    self?.sendTranslateRequest(text: bestString, completion: { (strings) in
                        DispatchQueue.main.async {
                            let utterance = AVSpeechUtterance(string: strings.first!)
                            utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
                            utterance.rate = 0.3
                            
                            let synthesizer = AVSpeechSynthesizer()
                            synthesizer.speak(utterance)
                        }
                    })
                }
            })
        }
    }
    
    private func requestSpeechAuthorization() {
        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.translateView.translateButton.isEnabled = true
                default:
                    self.translateView.translateButton.isEnabled = false
                }
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
