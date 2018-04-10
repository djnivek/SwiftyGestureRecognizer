//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    
    let label = UILabel()
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        label.frame = CGRect(x: 100, y: 200, width: 200, height: 20)
        label.text = "Press me if you can !"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        GestureRecognizer.install(label).pressed { (label, _) in
            if (label as? UILabel)?.textColor == .red {
                (label as? UILabel)?.textColor = .green
            } else {
                (label as? UILabel)?.textColor = .red
            }
        }
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
