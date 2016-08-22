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
    
    var translatedText: String = ""
    var callback: ( (String, Bool) -> Void)?
    private let yandexServiceApi = YandexServiceApi()
    var isAnimating = false
    
    func changedText (inputText : String) {
        
        if inputText.characters.count == 0 {
            
            self.isAnimating = false
            self.translatedText = ""
            notify()
            
        } else if inputText.characters.count > 2 {
            
            yandexServiceApi.sendRequestText (inputText) { data in
                self.isAnimating = true
                
                let translationListModel = data.1
                for value in translationListModel {
                    for value in value.tr!{
                        
                        self.translatedText = value.text!
                        print(self.translatedText)
                    }
                }
                self.isAnimating = false
                self.notify()
            }
        }
            
        else {
            
            self.isAnimating = false
            translatedText = "Oops,too short word, try again"
            notify()
        }
    }
    
    private func notify() {
        
        self.callback?(translatedText, isAnimating)
        
    }
}