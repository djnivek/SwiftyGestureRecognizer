//
//  SwiftyGestureRecognizer.swift
//  SwiftyGestureRecognizer
//
//  Created by Kevin MACHADO on 29/03/2018.
//  Copyright © 2018 SwiftyGestureRecognizer. All rights reserved.
//

import UIKit

public typealias TapGestureRecognizerBlock<P: UIView> = (_ attachedElement: P, _ recognizer: UIGestureRecognizer) -> Void



public class GestureRecognizer<P: UIView> {
    
    public var gestureRecognizer: UIGestureRecognizer?
    var element: P
    
    var excecutableBlock: TapGestureRecognizerBlock<P>?
    
    public init(for element: P) {
        self.element = element
        self.element.isUserInteractionEnabled = true
        
        GestureRecognizerStore.shared.add(view: element, with: self)
    }
    
    // MARK: - Setup
    
    public class func uninstall(_ element: P) {
        print("Uninstalling element \(element)")
        guard let recognizer = GestureRecognizerStore.shared.getRecognizer(by: element) as? GestureRecognizer<P> else {
            fatalError("No recognizer available for uninstalling")
        }
        recognizer.removeGestureRecognizer()
        GestureRecognizerStore.shared.remove(for: recognizer.element)
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
    
    public func pressed(_ excecutableBlock: @escaping TapGestureRecognizerBlock<P>) {
        self.excecutableBlock = excecutableBlock
        self.pressedGestureInit()
    }
    
    // MARK: - Selector
    
    @objc func action(recognizer: UIGestureRecognizer) {
        if let element = recognizer.view as? P {
            self.excecutableBlock?(element, recognizer)
        }
    }
    
}

