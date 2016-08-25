//
//  YandexServiceApi.swift
//  YandexTranslateApp
//
//  Created by Anna Gorobchenko on 22.08.16.
//  Copyright © 2016 Anna Gorobchenko. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import RxAlamofire
import RxCocoa
import RxSwift

class YandexServiceApi {
    
    // TODO     shareReplayLatestWhileConnected https://habrahabr.ru/post/283128/
    
    private var tempRequests = [Request]()
    
    
    
    let url = "https://dictionary.yandex.net/api/v1/dicservice.json/lookup"
    
    func sendRequestText (text : String, completionHandler: (Bool, [TranslationListModel]) -> ()) {
        
        let parameters = [
            "key": "dict.1.1.20160821T174005Z.9886aeaf3eba898f.06a3fa5e0f9d05c6d89934daae85402ce77a326c",
            "lang": "en-ru",
            "text": text ]
        
        var translationData = [TranslationListModel]()
        
        if  !tempRequests.isEmpty {
            //cancelRequest ()
            
        }
        
        let request = Alamofire.request(.POST, "https://dictionary.yandex.net/api/v1/dicservice.json/lookup", parameters: parameters)
            .responseObject{ (response: Response<TranslationResponseModel, NSError>) in
                if let td = response.result.value?.def {
                    translationData = td
                    completionHandler(true, translationData)
                } else {
                    completionHandler(false, translationData)
                    
                }
        }
        tempRequests.append(request)
    }
    
    
    /*
     
     func sendRequest(text : String) -> Observable <AnyObject?> {
     return create { observer in
     let request = Alamofire.request(.GET, "http://someapiurl.com", parameters: nil)
     .response(completionHandler:  { request, response, data, error in
     if ((error) != nil) {
     observer.on(.Error(error!))
     } else {
     observer.on(.Next(data))
     observer.on(.Completed)
     }
     });
     return AnonymousDisposable {
     request.cancel()
     }
     }
     }
     
     */
    
    func sendRequestToTranslate(text : String) -> Observable <String?> {
        
        let parameters = [
            "key": "dict.1.1.20160821T174005Z.9886aeaf3eba898f.06a3fa5e0f9d05c6d89934daae85402ce77a326c",
            "lang": "en-ru",
            "text": text ]
        
        
        return Alamofire.request(.POST, self.url, parameters: parameters)
            .rx_responseJSON()
            .map { (res: NSHTTPURLResponse, json: AnyObject) -> String? in
            
                guard let def = json["def"] as? [[String: AnyObject]],
                      let f = def.first?["tr"] as? [[String: AnyObject]],
                      let tr = f.first?["text"] as? String else {
                        
                        return "Error"
                }
                
                return tr
            }
        
       // return observable
        
        
//        
//        request.subscribeNext { (_) in
//            print("hello");
//        }
        
        
//       
//            request.map { (res: NSHTTPURLResponse, json: AnyObject) -> String? in
//                return String(request)
//            }
//            .subscribeNext{ (json: String? ) -> Void in
//                    
//                    if let dict = json as? [String: AnyObject] {
//                        let valDict = dict["def"] as! Dictionary<String, AnyObject>
//                        if let translatedTextArray = valDict["tr"] as? Dictionary<String, AnyObject> {
//                            if let translatedText = translatedTextArray["text"] as? String {
//                                observer.onNext(translatedText)
//                            }
//                        }
//                    }
//                    
        }
        
        
    }
    
    
    
//    
//    func cancelRequest () {
//        
//        for request in tempRequests {
//            
//            request.cancel()
//        }
//        
//    }


