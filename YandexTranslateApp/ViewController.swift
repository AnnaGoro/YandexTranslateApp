
import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    @IBOutlet weak var translatedText: UILabel!
    @IBOutlet weak var inputTextToTranslate: UITextField!
    
    private var viewModelTranslater  = ViewModelTranslater()
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        actInd.hidesWhenStopped = true;
        actInd.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.Gray;
        actInd.center = view.center
        
        inputTextToTranslate.rx_text
            
            .throttle(0.4, scheduler: MainScheduler.instance) // Wait 0.4 for changes.
            
            .distinctUntilChanged() // If they didn't occur, check if the new value is the same as old value
            
            .filter ({ (text : String?) -> Bool in
                let checkCount = text!.characters.count == 0
                
                if checkCount {
                    
                    self.viewModelTranslater.isAnimating.value = false
                    self.viewModelTranslater.translatedText.value  = ""
                    
                    return !checkCount
                    
                }
                return !checkCount
            })
            
            .filter ({ (text : String?) -> Bool in
                
                let checkCount = text!.characters.count < 3
                if checkCount{
                    
                    self.viewModelTranslater.isAnimating.value = false
                    self.viewModelTranslater.translatedText.value = "Oops, too short word"
                    
                    return !checkCount
                    
                }
                return !checkCount
                }
            )
            
            .subscribeNext { [unowned self] (textToTranslate : String) -> Void in
                
                self.viewModelTranslater.changedText(textToTranslate)
                
            }
            .addDisposableTo(bag)
        
        
        viewModelTranslater.translatedText.asObservable()
            .subscribeNext { (translatedText: String) -> Void in
                self.translatedText.text = translatedText
            }
            .addDisposableTo(bag)
        
        viewModelTranslater.isAnimating.asObservable()
            .subscribeNext { (isAnimating: Bool) -> Void in
                if isAnimating {
                    self.actInd.startAnimating()
                    
                } else {
                    
                    self.actInd.stopAnimating()
                }
            }
            .addDisposableTo(bag)
        
        
        
    }
}
