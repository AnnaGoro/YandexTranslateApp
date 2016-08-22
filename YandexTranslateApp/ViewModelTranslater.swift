//
//  ViewModelTranslater.swift
//  YandexTranslateApp
//
//  Created by Anna Gorobchenko on 22.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import UIKit

class ViewModelTranslater {
    weak var actInd = UIActivityIndicatorView()
    var translatedText: String = ""
    var callback: ( (String, Bool) -> Void)?
    var yandexServiceApi = YandexServiceApi()
    var translationModel = [TranslationModel]()
    var arrayText = [String]()
    var isAnimating = true
    
    func changedText (inputText : String) {
         if inputText.characters.count > 2 {
        yandexServiceApi.sendRequestText (inputText) { data in
            self.isAnimating = true
            //self.actInd!.startAnimating()
            let translationListModel = data.1
            for value in translationListModel {
                //print (" get text to translate from \(value.text)")
                for value in value.tr! {
                    print (" get text to translate from \(value.text)")
                    self.translationModel.append(value)
                    self.arrayText.append(value.text!)
                    //self.translatedText = value.text!
                    self.translatedText = self.arrayText[0]
                    }
                
                 }
             self.isAnimating = false
             self.notify()
             print(" translatedText \(self.translatedText)")
        }
        
         } else {
        
         translatedText = "Oops,too short word, try again"
         self.notify()
        }
}
    
    func notify() {
       
        self.callback!(translatedText, isAnimating)
    
    }
}