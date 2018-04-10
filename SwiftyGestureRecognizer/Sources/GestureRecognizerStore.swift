//
//  SwiftyGestureRecognizerStore.swift
//  SwiftyGestureRecognizer-iOS
//
//  Created by Kévin MACHADO on 10/04/2018.
//  Copyright © 2018 SwiftyGestureRecognizer. All rights reserved.
//

import UIKit

class GestureRecognizerStore<P: UIView, T: UIGestureRecognizer> {
    
    static func sharedGestureRecognizerStore<P: UIView, T: UIGestureRecognizer>() -> GestureRecognizerStore<P, T> {
        return GestureRecognizerStore<P, T>()
    }
    
    var recognizers: [P:GestureRecognizer<P, T>] = [:] as! [P : GestureRecognizer]
    func add(view: P, with recognizer: GestureRecognizer<P, T>) {
        self.recognizers[view] = recognizer
    }
    func getRecognizer(by view: P) -> GestureRecognizer<P, T>? {
        return self.recognizers[view]
    }
    func remove(for view: P) {
        self.recognizers.removeValue(forKey: view)
    }
    func removeAll() {
        self.recognizers.removeAll()
    }
    func forEachRecognizer(forEach: (_ recognizer: GestureRecognizer<P, T>) -> Void) {
        for key in recognizers.keys {
            if let rec = recognizers[key] {
                forEach(rec)
            }
        }
    }
}
