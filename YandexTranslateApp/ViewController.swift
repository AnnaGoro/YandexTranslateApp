//
//  ViewController.swift
//  YandexTranslateApp
//
//  Created by Anna Gorobchenko on 22.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate  {
    private let viewModelTranslater  = ViewModelTranslater()
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var translatedText: UILabel!
    @IBOutlet weak var inputTextToTranslate: UITextField!
    override func viewDidLoad() {
        actInd.hidesWhenStopped = true;
        actInd.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.Gray;
        actInd.center = view.center;
        super.viewDidLoad()
        inputTextToTranslate.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        viewModelTranslater.callback = { [unowned self]  text, isAnimating  in   //react3
            print("callback viewController")
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

    func testChange() {   
    
       viewModelTranslater.changedText(inputTextToTranslate.text!)
        
    }
    
}

