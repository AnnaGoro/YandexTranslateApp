//
//  TranslationListModel.swift
//  YandexTranslateApp
//
//  Created by Anna Gorobchenko on 22.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper


class TranslationListModel : Mappable {
    
    
    var text : String?
    var pos : String?
    var tr : [TranslationModel]?
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        
        text <- map["text"]
        pos <- map["pos"]
        tr <- map["tr"]
       
        
    }
    
    
    
    
}