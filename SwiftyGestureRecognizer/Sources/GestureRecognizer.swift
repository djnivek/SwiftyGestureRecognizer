//
//  SwiftyGestureRecognizer.swift
//  SwiftyGestureRecognizer
//
//  Created by Kevin MACHADO on 29/03/2018.
//  Copyright © 2018 SwiftyGestureRecognizer. All rights reserved.
//

import UIKit

public typealias TapGestureRecognizerBlock<P: UIView> = (_ attachedElement: P, _ recognizer: UITapGestureRecognizer) -> Void
public typealias RotationGestureRecognizerBlock<P: UIView> = (_ attachedElement: P, _ recognizer: UIRotationGestureRecognizer) -> Void
public typealias PanGestureRecognizerBlock<P: UIView> = (_ attachedElement: P, _ recognizer: UIPanGestureRecognizer) -> Void
public typealias PinchGestureRecognizerBlock<P: UIView> = (_ attachedElement: P, _ recognizer: UIPinchGestureRecognizer) -> Void

public class GestureRecognizer<P: UIView> {
    
    public var gestureRecognizer: UIGestureRecognizer?
    var element: P
    
    var excecutableBlockTap: TapGestureRecognizerBlock<P>?
    var excecutableBlockRotation: RotationGestureRecognizerBlock<P>?
    var excecutableBlockPan: PanGestureRecognizerBlock<P>?
    var excecutableBlockPinch: PinchGestureRecognizerBlock<P>?
    
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
        self.gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(actionTap(recognizer:)))
        self.add(gestureRecognizer: self.gestureRecognizer!, to: self.element)
    }
    
    public func pressed(_ excecutableBlock: @escaping TapGestureRecognizerBlock<P>) {
        self.excecutableBlockTap = excecutableBlock
        self.pressedGestureInit()
    }
    
    // MARK: RotationGesture
    
    private func rotationGestureInit() {
        self.element.isMultipleTouchEnabled = true
        self.gestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(actionRotation(recognizer:)))
        self.add(gestureRecognizer: self.gestureRecognizer!, to: self.element)
    }
    
    public func rotatable() {
        self.rotationGestureInit()
    }
    
    public func rotated(_ excecutableBlock: @escaping RotationGestureRecognizerBlock<P>) {
        self.excecutableBlockRotation = excecutableBlock
        self.rotationGestureInit()
    }
    
    // MARK: - PanGesture
    
    private func panGestureInit() {
        self.gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(actionPan(recognizer:)))
        self.add(gestureRecognizer: self.gestureRecognizer!, to: self.element)
    }
    
    public func pannable() {
        self.panGestureInit()
    }
    
    public func panned(_ excecutableBlock: @escaping PanGestureRecognizerBlock<P>) {
        self.excecutableBlockPan = excecutableBlock
        self.panGestureInit()
    }
    
    // MARK: - PinchGesture
    
    private func pinchGestureInit() {
        self.element.isMultipleTouchEnabled = true
        self.gestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(actionPinch(recognizer:)))
        self.add(gestureRecognizer: self.gestureRecognizer!, to: self.element)
    }
    
    public func pinchable() {
        self.pinchGestureInit()
    }
    
    public func pinched(_ excecutableBlock: @escaping PinchGestureRecognizerBlock<P>) {
        self.excecutableBlockPinch = excecutableBlock
        self.pinchGestureInit()
    }
    
    // MARK: - Selector
    
    @objc func actionTap(recognizer: UITapGestureRecognizer) {
        if let element = recognizer.view as? P {
            self.excecutableBlockTap?(element, recognizer)
        }
    }
    
    var lastRotation = CGFloat()
    @objc func actionRotation(recognizer: UIRotationGestureRecognizer) {
        if let element = recognizer.view as? P {
            var originalRotation = CGFloat()
            if recognizer.state == .began {
                print("sender.rotation: \(recognizer.rotation)")
                // sender.rotation renews everytime the rotation starts
                // delta value but not absolute value
                recognizer.rotation = lastRotation
                // the last rotation is the relative rotation value when rotation stopped last time,
                // which indicates the current rotation
                originalRotation = recognizer.rotation
            } else if recognizer.state == .changed {
                let newRotation = recognizer.rotation + originalRotation
                recognizer.view?.transform = CGAffineTransform(rotationAngle: newRotation)
                self.excecutableBlockRotation?(element, recognizer)
            } else if recognizer.state == .ended {
                // Save the last rotation
                lastRotation = recognizer.rotation
            }
        }
    }
    
    var initialCenter = CGPoint()  // The initial center point of the view.
    @objc func actionPan(recognizer: UIPanGestureRecognizer) {
        guard let element = recognizer.view as? P else { return }
        // Get the changes in the X and Y directions relative to
        // the superview's coordinate space.
        let translation = recognizer.translation(in: element.superview)
        if recognizer.state == .began {
            // Save the view's original position.
            self.initialCenter = element.center
        }
        // Update the position for the .began, .changed, and .ended states
        if recognizer.state != .cancelled {
            // Add the X and Y translation to the view's original position.
            let newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            element.center = newCenter
            self.excecutableBlockPan?(element, recognizer)
        }
        else {
            // On cancellation, return the piece to its original location.
            element.center = initialCenter
        }
    }
    
    @objc func actionPinch(recognizer : UIPinchGestureRecognizer) {
        guard let element = recognizer.view as? P else { return }
        if recognizer.state == .began || recognizer.state == .changed {
            element.transform = element.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1.0
            self.excecutableBlockPinch?(element, recognizer)
        }
    }
    
}

