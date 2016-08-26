
import Foundation
import UIKit
import RxSwift

struct ViewModelTranslater {
    
    var translatedText: Variable <String> = Variable( "" )
    var isAnimating : Variable <Bool> = Variable( false )
    
    private var yandexServiceApi = YandexServiceApi()
    private let bag = DisposeBag()
    
    var observableViewModelTextField : Observable <String>? {
        
        didSet {
            guard let observable = observableViewModelTextField else { return }
            
            observable
                
                .throttle(0.4, scheduler: MainScheduler.instance) // Wait 0.4 for changes.
                
                .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old value
                
                .filter ({ (text : String?) -> Bool in
                    let checkCount = text!.characters.count == 0
                    
                    if checkCount {
                        
                        self.isAnimating.value = false
                        self.translatedText.value  = ""
                        
                        return !checkCount                        
                    }
                    return !checkCount
                })
                
                .filter ({ (text : String?) -> Bool in
                    
                    let checkCount = text!.characters.count < 3
                    if checkCount{
                        
                        self.isAnimating.value = false
                        self.translatedText.value = "Oops, too short word"
                        
                        return !checkCount
                    }
                    return !checkCount
                    }
                )
                
                .subscribeNext { (inputText: String) -> Void in
                    self.changedText(inputText)
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

