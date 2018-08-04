//
//  SwiftyGestureRecognizerStore.swift
//  SwiftyGestureRecognizer-iOS
//
//  Created by Kévin MACHADO on 10/04/2018.
//  Copyright © 2018 SwiftyGestureRecognizer. All rights reserved.
//

import UIKit

class GestureRecognizerStore {
    
    static var shared = GestureRecognizerStore()
    
    var recognizers: [UIView:GestureRecognizer] = [:] as! [UIView : GestureRecognizer]
    
    func add<T>(view: T, with recognizer: GestureRecognizer<T, UIGestureRecognizer>) {
        self.recognizers[view] = (recognizer as! GestureRecognizer<UIView, UIGestureRecognizer>)
    }
    func getRecognizer<T: UIView>(by view: T, t: T.Type = T.self) -> GestureRecognizer<UIView, UIGestureRecognizer>? {
        return self.recognizers[view]
    }
    func remove<T: UIView>(for view: T) {
        self.recognizers.removeValue(forKey: view)
    }
    func removeAll() {
        self.recognizers.removeAll()
    }
    func forEachRecognizer(forEach: (_ recognizer: GestureRecognizer<UIView, UIGestureRecognizer>) -> Void) {
        for key in recognizers.keys {
            if let rec = recognizers[key] {
                forEach(rec)
            }
        }
    }
}
