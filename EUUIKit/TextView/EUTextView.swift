//
//  EUTextView.swift
//  EUUIKit
//
//  Created by Harlans on 2019/4/30.
//  Copyright © 2019 Harlans. All rights reserved.
//

import UIKit

class EUTextView: UITextView {

    @IBInspectable var placeholder: String = "" {
        didSet {
            if self.text == "" {
                self.text = placeholder
            }
        }
    }
    @IBInspectable var placeholderColor: UIColor = .clear {
        didSet {
            self.textColor = placeholderColor
        }
    }
    
    init() {
        super.init(frame: .zero, textContainer: .none)
        self.alwaysBounceVertical = true
        self.font = UIFont.systemFont(ofSize: 15)
        self.placeholderColor = UIColor.lightText
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func becomeFirstResponder() -> Bool {
        if self.text == placeholder || self.text == "" {
            self.text = ""
            self.textColor = .black
        }
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        text = self.text.replacingOccurrences(of: " ", with: "")
        if text == "" {
            self.text = placeholder
            self.textColor = .lightGray
        }
        return super.resignFirstResponder()
    }
    
}
