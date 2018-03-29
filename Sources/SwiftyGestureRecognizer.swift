//
//  SwiftyGestureRecognizer.swift
//  SwiftyGestureRecognizer
//
//  Created by Kevin MACHADO on 29/03/2018.
//  Copyright © 2018 SwiftyGestureRecognizer. All rights reserved.
//

import UIKit

public typealias TapGestureRecognizerBlock = (_ attachedElement: UIView?, _ recognizer: UIGestureRecognizer) -> Void

class GestureRecognizerStore {
    static var shared = GestureRecognizerStore()
    var recognizers: [UIView:GestureRecognizer] = [:]
    func add(view: UIView, with recognizer: GestureRecognizer) {
        self.recognizers[view] = recognizer
    }
    func getRecognizer(by view: UIView) -> GestureRecognizer? {
        return self.recognizers[view]
    }
    func remove(for view: UIView) {
        self.recognizers.removeValue(forKey: view)
    }
    func removeAll() {
        self.recognizers.removeAll()
    }
    func forEachRecognizer(forEach: (_ recognizer: GestureRecognizer?) -> Void) {
        for key in recognizers.keys {
            forEach(recognizers[key])
        }
    }
}

public class GestureRecognizer {
    
    var gestureRecognizer: UIGestureRecognizer?
    var element: UIView
    
    var excecutableBlock: TapGestureRecognizerBlock?
    
    init(element: UIView) {
        self.element = element
        self.element.isUserInteractionEnabled = true
    }
    
    public class func install(_ element: UIView) -> GestureRecognizer {
        let recognizer = GestureRecognizer(element: element)
        GestureRecognizerStore.shared.add(view: element, with: recognizer)
        return recognizer
    }
    
    public class func uninstall(_ element: UIView) {
        guard let recognizer = GestureRecognizerStore.shared.getRecognizer(by: element) else { return }
        recognizer.removeGestureRecognizer()
        GestureRecognizerStore.shared.remove(for: recognizer.element)
    }
    
    public class func uninstallAll() {
        GestureRecognizerStore.shared.forEachRecognizer {
            if let recognizer = $0 {
                recognizer.removeGestureRecognizer()
            }
        }
        GestureRecognizerStore.shared.removeAll()
    }
    
    // MARK: - LifeCycle
    
    private func add(gestureRecognizer: UIGestureRecognizer, to element: UIView) {
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
    
    public func pressed(_ excecutableBlock: @escaping TapGestureRecognizerBlock) {
        self.excecutableBlock = excecutableBlock
        self.pressedGestureInit()
    }
    
    // MARK: - Selector
    
    @objc func action(recognizer: UIGestureRecognizer) {
        self.excecutableBlock?(recognizer.view, recognizer)
    }
    
}

