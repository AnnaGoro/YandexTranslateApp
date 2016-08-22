//
//  ViewModelTranslater.swift
//  YandexTranslateApp
//
//  Created by Anna Gorobchenko on 22.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation



class ViewModelTranslater {

    var translatedText: String = ""
    var callback: ( (String) -> Void)?
    var yandexServiceApi = YandexServiceApi()
    var translationModel = [TranslationModel]()
    var arrayText: [String]?
    func changedText (inputText : String) {
        
        yandexServiceApi.sendRequestText (inputText) { data in
            
            
            let translationListModel = data.1
            for value in translationListModel {
                //print (" get text to translate from \(value.text)")
                for value in value.tr! {
                    print (" get text to translate from \(value.text)")
                    self.translationModel.append(value)
                    //self.arrayText.append(value.text!)
                    self.translatedText = value.text!

                }
                
                 }
             //self.translatedText = arrayText[0].
             self.notify()
        }
         print(" translatedText \(translatedText)")
        
}
    
    func notify() {
    
        self.callback!(translatedText)
    
    }
}