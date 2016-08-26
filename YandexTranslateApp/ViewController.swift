
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
        
        viewModelTranslater.observableViewModelTextField = inputTextToTranslate.rx_text.asObservable()
              
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
