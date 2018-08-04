//
//  SwiftyGestureRecognizer.swift
//  SwiftyGestureRecognizer
//
//  Created by Kevin MACHADO on 29/03/2018.
//  Copyright © 2018 SwiftyGestureRecognizer. All rights reserved.
//

import UIKit

public typealias TapGestureRecognizerBlock<P: UIView, T: UIGestureRecognizer> = (_ attachedElement: P, _ recognizer: T) -> Void

public class GestureRecognizer<P: UIView, T: UIGestureRecognizer> {
    
    public var gestureRecognizer: UIGestureRecognizer?
    var element: P
    
    var excecutableBlock: TapGestureRecognizerBlock<P, T>?
    
    init(element: P) {
        self.element = element
        self.element.isUserInteractionEnabled = true
    }
    
    // MARK: - Setup
    
    public class func install(_ element: P) -> GestureRecognizer {
        print("Installing element \(element)")
        let recognizer = GestureRecognizer(element: element)
        GestureRecognizerStore.shared.add(view: element, with: recognizer as! GestureRecognizer<UIView, UIGestureRecognizer>)
        return recognizer
    }
    
    public class func uninstall(_ element: P) {
        print("Uninstalling element \(element)")
        guard let recognizer = GestureRecognizerStore.shared.getRecognizer(by: element) else {
            fatalError("No recognizer available for uninstalling")
        }
        recognizer.removeGestureRecognizer()
        GestureRecognizerStore.shared.remove(for: recognizer.element)
    }
    
    public class func _debugGet(for element: P) -> GestureRecognizer<P, T> {
        return GestureRecognizerStore.shared.getRecognizer(by: element) as! GestureRecognizer<P, T>
    }
    
    public class func uninstallAll() {
        GestureRecognizerStore.shared.forEachRecognizer {
            $0.removeGestureRecognizer()
        }
        GestureRecognizerStore.shared.removeAll()
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

