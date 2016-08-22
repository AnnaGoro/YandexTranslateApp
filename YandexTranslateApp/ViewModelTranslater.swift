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
    private var yandexServiceApi = YandexServiceApi()
    var isAnimating = false
    
    func changedText (inputText : String) {
        
        isAnimating = true
       
        if inputText.characters.count == 0 {
            
            isAnimating = false
            translatedText = ""
            
        } else if inputText.characters.count > 2 {
            
            yandexServiceApi.sendRequestText (inputText) { [weak self] data in
                
                let translationListModel = data.1
                if let value = translationListModel.first {
                    self!.translatedText = (value.tr?.first?.text)!
                    self!.isAnimating = false
                    self!.notify()
                }
            }
            
        } else {
            
            self.isAnimating = false
            translatedText = "Oops,too short word, try again"
         
        }
            notify()
    }
    
    private func notify() {
        
        self.callback?(translatedText, isAnimating)
        
    }
}