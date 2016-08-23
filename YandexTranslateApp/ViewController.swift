//
//  ViewController.swift
//  YandexTranslateApp
//
//  Created by Anna Gorobchenko on 22.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var translatedText: UILabel!
    @IBOutlet weak var inputTextToTranslate: UITextField!
    private var viewModelTranslater  = ViewModelTranslater()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actInd.hidesWhenStopped = true;
        actInd.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.Gray;
        actInd.center = view.center
        
        inputTextToTranslate.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        viewModelTranslater.callback = { [unowned self]  text, isAnimating  in
            
            self.translatedText.text = text
            
            switch isAnimating {
                
                case true : self.actInd.startAnimating()
                case false : self.actInd.stopAnimating()
                
            }
         
        }
        testChange()
    }
    
    func textFieldDidChange(textField: UITextField) {
        
        testChange()

    }
    
    private func testChange() {
        
        viewModelTranslater.changedText(inputTextToTranslate.text!)
        
    }
    
}

