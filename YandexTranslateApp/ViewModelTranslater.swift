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
   
    private var previous = ""
    
    func changedText (inputText : String) {
        
        let current = inputText
        isAnimating = true
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (Int64)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), {
            
            
            if inputText.characters.count > 2 {
                
                if self.previous == inputText {
                    
                    self.yandexServiceApi.sendRequestText (inputText) { [weak self] data in
                        /*
                        if data.0 == false {
                            
                            self!.isAnimating = false
                            self!.translatedText = "Error, check your network connection"
                            return
                            
                        } else {
                            */
                            let translationListModel = data.1
                            
                            if  let value = translationListModel.first {
                                
                                self!.translatedText = (value.tr?.first?.text)!
                                self!.isAnimating = false
                                
                            }
                       // }
                        
                        self!.notify()
                    }
                    
                } else {
                    
                    self.translatedText = "Error, smth wrong"
                    self.isAnimating = false
                    
                }
                
            } else if inputText.characters.count == 0 {
                
                self.isAnimating = false
                self.translatedText = ""
                
            } else {
                
                self.translatedText = "Error, too short word"
                self.isAnimating = false
                
            }
            
            self.notify()
        });
        
        let temp = current
        self.previous = temp
        
        notify()
    }
    
    
    private func notify() {
        
        self.callback?(translatedText, isAnimating)
        
    }
}

