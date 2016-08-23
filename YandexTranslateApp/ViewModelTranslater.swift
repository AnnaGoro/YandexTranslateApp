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
    
    var previous = ""
    var next = ""
    
    func changedText (inputText : String) {
        
        isAnimating = true
       
        if inputText.characters.count == 0 {
            
            isAnimating = false
            translatedText = ""
            
            
        } else if inputText.characters.count > 2 {
            
            var temp = next
            previous = temp
            next = inputText
            
            print("***previous**\(previous)")
            print("***next**\(next)")
            print("---------------------")
            
            if previous == next {
                
                yandexServiceApi.sendRequestText (inputText) { [weak self] data in
                
                if data.0 == false {
                
                    self!.isAnimating = false
                    self!.translatedText = "Error, check your network connection"
                    return
               
                } else {
                    
                    let translationListModel = data.1
                        
                    if  let value = translationListModel.first {
                        self!.translatedText = (value.tr?.first?.text)!
                        self!.isAnimating = false
                    
                    }
                }
                
                self!.notify()
                
                }
            }
            
        } else {
            
            translatedText = "Error, smth wrong"
            isAnimating = false
            return
         
        }
        
        notify()
    }
    

    
    private func notify() {
        
        self.callback?(translatedText, isAnimating)
        
    }
}

