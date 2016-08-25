//
//  ViewController.swift
//  YandexTranslateApp
//
//  Created by Anna Gorobchenko on 22.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var translatedText: UILabel!
    @IBOutlet weak var inputTextToTranslate: UITextField!
    private var viewModelTranslater  = ViewModelTranslater()
    
    private let bag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actInd.hidesWhenStopped = true;
        actInd.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.Gray;
        actInd.center = view.center
        
        inputTextToTranslate.rx_text.subscribeNext { (textToTranslate : String) -> Void in
            self.viewModelTranslater.changedText(textToTranslate)
            }
            .addDisposableTo(bag)
        
        
        viewModelTranslater.translatedText.asObservable()
            .subscribeNext { (translatedText: String) -> Void in
                self.translatedText.text = translatedText
            }
            .addDisposableTo(bag)
        
        viewModelTranslater.isAnimating.asObservable()
            .subscribeNext { (isAnimating: Bool) -> Void in
                if isAnimating {
                    self.actInd.startAnimating()
                    
                } else {
                    
                    self.actInd.startAnimating()
                }
            }
            .addDisposableTo(bag)
        
        
        
    }
}
