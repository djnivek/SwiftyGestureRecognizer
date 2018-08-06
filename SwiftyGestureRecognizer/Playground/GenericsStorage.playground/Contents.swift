import UIKit

//class GestureRecognizer<T: UIView, R: UIGestureRecognizer> {
//
//    var element: T
//
//    var recognizer: UIGestureRecognizer?
//
//    init(for element: T) {
//        self.element = element
//    }
//
//    static func install(_ view: T) -> GestureRecognizer {
//        let rec = GestureRecognizer(for: view)
//        GestureRecognizerStore.shared.add(rec)
//        return rec
//    }
//
//    static func uninstall(_ view: T) {
//        GestureRecognizerStore.shared.remove(view)
//    }
//
//    func press<T, R>(completion block: (_ view: T, _ rec: R) -> Void) {
//        self.recognizer = UIPanGestureRecognizer(target: element, action: nil)
//    }
//
//}
//
//
//class GestureRecognizerStore {
//
//    static let shared = GestureRecognizerStore()
//
//    var datas: [Any] = []
//
//    func add<T, R>(_ recognizer: GestureRecognizer<T, R>) {
//        datas.append(recognizer)
//    }
//
//    func remove(_ view: UIView) {
//        var i: Int?
//        for (index, reco) in datas.enumerated() {
//            if (reco as! GestureRecognizer).element == view {
//                i = index
//                continue
//            }
//        }
//        if let index = i {
//            datas.remove(at: index)
//        }
//    }
//
//}
//
//let label = UILabel()
//Gesture.install(label).press { (test, fes) in
//
//}





/*

# OK #                  # OK #
# OK #                  # OK #                  # OK #                  # OK #
# OK #                  # OK #                  # OK #                  # OK #
# OK #                  # OK #

*/

//typealias CompletionBlock<T, P> = (_ view: T, _ test: P) -> Void
//
//enum Gestures<T, P> {
//    case press(CompletionBlock<T, P>)
//}
//
//class SwiftyGesture<T: UIView, P: UIGestureRecognizer> {
//
//    var target: T
//
//    var gesture: P
//
//    init(for target: T, on: Gestures<T, P>) {
//        self.target = target
//        switch on {
//        case .press:
//            self.gesture = UITapGestureRecognizer(target: self.target, action: nil) as! P
//        }
//    }
//
//}
//
//
//typealias Press = UITapGestureRecognizer
//
//SwiftyGesture(for: UILabel(), on: .press { element, moi in
//
//})





/*
 
 # OK #                  # OK #
 # OK #                  # OK #                  # OK #                  # OK #
 # OK #                  # OK #                  # OK #                  # OK #
 # OK #                  # OK #
 
 */

typealias TapCompletionBlock<T> = (_ view: T, _ numberOfTaps: Int) -> Void

class SwiftyGesture<T: UIView, P: UIGestureRecognizer> {
    
    var target: T
    
    var gesture: UIGestureRecognizer?
    
    init(for target: T) {
        self.target = target
    }
    
    func press(_ block: TapCompletionBlock<T>) {
        self.gesture = UITapGestureRecognizer(target: self.target, action: nil)
    }
}


typealias Press = UITapGestureRecognizer

SwiftyGesture(for: UILabel()).press { (label, _) in
    
}
