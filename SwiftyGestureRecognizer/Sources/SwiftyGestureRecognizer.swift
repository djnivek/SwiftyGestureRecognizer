//
//  SwiftyGestureRecognizer.swift
//  SwiftyGestureRecognizer
//
//  Created by Kevin MACHADO on 29/03/2018.
//  Copyright © 2018 SwiftyGestureRecognizer. All rights reserved.
//

import UIKit

public typealias TapGestureRecognizerBlock<P: UIView, T: UIGestureRecognizer> = (_ attachedElement: P, _ recognizer: T) -> Void

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

public class GestureRecognizer<P: UIView, T: UIGestureRecognizer> {
    
    var gestureRecognizer: UIGestureRecognizer?
    var element: P
    
    var excecutableBlock: TapGestureRecognizerBlock<P, T>?
    
    //associatedtype view: T
    //associatedtype recognizer: P
    
    init(element: P) {
        self.element = element
        self.element.isUserInteractionEnabled = true
    }
    
    public class func install(_ element: P) -> GestureRecognizer {
        let recognizer = GestureRecognizer(element: element)
        GestureRecognizerStore.sharedGestureRecognizerStore().add(view: element, with: recognizer)
        return recognizer
    }
    
    public class func uninstall(_ element: P) {
        guard let recognizer = GestureRecognizerStore.sharedGestureRecognizerStore().getRecognizer(by: element) else { return }
        recognizer.removeGestureRecognizer()
        GestureRecognizerStore.sharedGestureRecognizerStore().remove(for: recognizer.element)
    }
    
    public class func uninstallAll() {
        GestureRecognizerStore.sharedGestureRecognizerStore().forEachRecognizer {
            $0.removeGestureRecognizer()
        }
        GestureRecognizerStore.sharedGestureRecognizerStore().removeAll()
    }
    
    // MARK: - LifeCycle
    
    private func add(gestureRecognizer: UIGestureRecognizer, to element: P) {
        element.addGestureRecognizer(self.gestureRecognizer!)
    }
    
    private func removeGestureRecognizer() {
        if let gestureRecognizer = self.gestureRecognizer {
            self.element.removeGestureRecognizer(gestureRecognizer)
        }
    }
    
    // MARK: - Actions
    
    // MARK: TapGesture
    
    private func pressedGestureInit() {
        self.gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(action(recognizer:)))
        self.add(gestureRecognizer: self.gestureRecognizer!, to: self.element)
    }
    
    public func pressed(_ excecutableBlock: @escaping TapGestureRecognizerBlock<P, T>) {
        self.excecutableBlock = excecutableBlock
        self.pressedGestureInit()
    }
    
    // MARK: - Selector
    
    @objc func action(recognizer: UIGestureRecognizer) {
        if let element = recognizer.view as? P, let rec = recognizer as? T {
            self.excecutableBlock?(element, rec)
        }
    }
    
}

