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
    
    func changedText (inputText : String) {
        
        yandexServiceApi.sendRequestText (inputText) { data in
            
            
            let translationListModel = data.1
            for value in translationListModel {
                //print (" get text to translate from \(value.text)")
                for value in value.tr! {
                    print (" get text to translate from \(value.text)")
                    self.translationModel.append(value)}
                
                 }
           
        }
         self.translatedText = (self.translationModel.first?.text)!
         notify()
}
    
    func notify() {
    
        self.callback!(translatedText)
    
    }
}