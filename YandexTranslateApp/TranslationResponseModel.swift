//
//  TranslationResponseModel.swift
//  YandexTranslateApp
//
//  Created by Anna Gorobchenko on 22.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import ObjectMapper


class TranslationResponseModel : Mappable {
    
    
    var def : [TranslationListModel]?
    
    
    
    required init?(_ map: Map){
        
    }
    
    func mapping(map: Map) {
        
        def <- map["def"]
        
        
    }
    
    
    
    
}