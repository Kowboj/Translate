//
//  TranslateView.swift
//  Translate
//
//  Created by Kamil Chołyk on 15/04/2019.
//  Copyright © 2019 kowboj. All rights reserved.
//

import UIKit

final class TranslateView: UIView {
    
    private(set) lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.textColor = .black
        textField.placeholder = "Enter text..."
        return textField
    }()
    
    private(set) lazy var translateButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        button.layer.cornerRadius = 10
        button.setTitle("Translate", for: .normal)
        return button
    }()
    
    private(set) lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .black
        label.text = "Result will be here"
        return label
    }()
    
    override static var requiresConstraintBasedLayout: Bool {
        return true
    }
    
    init() {
        super.init(frame: .zero)
        setupViewHierarchy()
        setupProperties()
        setupLayoutConstraints()
    }
    
    func setupViewHierarchy() {
        [searchTextField, translateButton, resultLabel].forEach(addSubview)
    }
    
    func setupLayoutConstraints() {
        NSLayoutConstraint.activate([
            searchTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            searchTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            searchTextField.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            
            translateButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            translateButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            translateButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 100),
            
            resultLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            resultLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            resultLabel.topAnchor.constraint(equalTo: translateButton.bottomAnchor, constant: 100)
            ])
    }
    
    func setupProperties() {
        backgroundColor = .white
    }
    
    @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
