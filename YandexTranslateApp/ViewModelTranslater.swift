
import Foundation
import UIKit
import RxSwift

struct ViewModelTranslater {
    
    let translatedText: Variable <String> = Variable( "" )
    let isAnimating : Variable <Bool> = Variable( false )
    
    private let yandexServiceApi = YandexServiceApi()
    private let bag = DisposeBag()
    private var checkCount = false
    
    var observableViewModelTextField : Observable <String>? {
        
        didSet {
            guard let observable = observableViewModelTextField else { return }
            
            observable
                .throttle(0.4, scheduler: MainScheduler.instance)
                .subscribeNext { (inputText: String) -> Void in                    
                    if  inputText.characters.count < 3 {
                        
                        self.isAnimating.value = false
                        self.translatedText.value  = ""
                        return
                        
                    } else {
                        self.changedText(inputText)
                    }
                    
                }
                .addDisposableTo(bag)
        }
    }
    
    mutating func changedText(text : String) {
        
        self.isAnimating.value =  true
        
        self.yandexServiceApi.sendRequestToTranslate(text)
            .subscribe(
                onNext: { translatedTextYandex  in
                    
                    self.translatedText.value = translatedTextYandex!
                    self.isAnimating.value = false
                },
                onError: { translatedTextYandex in
                    
                    self.translatedText.value = "Error, check your network connection"
                    self.isAnimating.value = false
                }
            )
            .addDisposableTo(bag)
        
    }
}

