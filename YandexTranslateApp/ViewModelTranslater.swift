

import Foundation
import UIKit
import RxSwift

struct ViewModelTranslater {
    
    var translatedText: Variable <String> = Variable( "" )
    
    private var yandexServiceApi = YandexServiceApi()
    var isAnimating : Variable <Bool> = Variable( false )
    
    private let bag = DisposeBag()
    
    mutating func changedText(text : String) {
        
        self.isAnimating.value =  true
        
        self.yandexServiceApi.sendRequestToTranslate(text)
            
            .subscribe(
                onNext: { translatedTextYandex  in
                    
                    self.translatedText.value = translatedTextYandex!
                    self.isAnimating.value = false
                    print(self.translatedText.value)
                    
                },
                
                onError: { translatedTextYandex in
                    
                    self.translatedText.value = "Error, check your network connection"
                    self.isAnimating.value = false
                    print(self.translatedText.value)
                    
                }
            )
            .addDisposableTo(bag)
        
    }
}

