
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
    
    
    func sendRequestToTranslate(text : String) -> Observable <String?> {
        
        let parameters = [
            "key": "dict.1.1.20160821T174005Z.9886aeaf3eba898f.06a3fa5e0f9d05c6d89934daae85402ce77a326c",
            "lang": "en-ru",
            "text": text ]
        
        
        return Alamofire.request(.POST, self.url, parameters: parameters)
            .rx_responseJSON().shareReplayLatestWhileConnected().debug("http")
            .map { (res: NSHTTPURLResponse, json: AnyObject) -> String? in
                
                guard let def = json["def"] as? [[String: AnyObject]],
                    let f = def.first?["tr"] as? [[String: AnyObject]],
                    let tr = f.first?["text"] as? String else {
                        
                        return "Oops, no translation, try again"
                }
                
                return tr
        }
        
        
    }
    
    
       
}


