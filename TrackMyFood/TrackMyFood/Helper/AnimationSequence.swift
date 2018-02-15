//
//  AnimationSequence.swift
//  TrackMyFood
//
//  Created by Kerim Njuhovic on 12/5/17.
//  Copyright © 2017 Kerim Njuhovic. All rights reserved.
//

import Foundation
import UIKit

final private class ViewAnimationStep {
    fileprivate var completed: (() -> Void) = { }
    fileprivate let animations: (() -> Void)
    fileprivate let duration: Double
    
    init(withAnimations animations: @escaping (() -> Void), duration: Double) {
        self.animations = animations
        self.duration = duration
    }
    
    func onCompleted(completed: @escaping (() -> Void)) -> Self {
        self.completed = completed
        return self
    }
    
    func execute() {
        UIView.animate(withDuration: duration, animations: {
            self.completed()
        })
    }
}

internal class AnimationSequence {
    fileprivate var completion: (() -> Void) = { }
    fileprivate var sequence = [ViewAnimationStep]()
    fileprivate var stepDuration: Double
    
    init(withStepDuration stepDuration: Double) {
        self.stepDuration = stepDuration
    }
    
    @discardableResult
    func doStep(_ animations: @escaping (() -> Void)) -> Self {
        let step = ViewAnimationStep(withAnimations: animations, duration: stepDuration)
        sequence.append(step)
        
        return self
    }
    
    @discardableResult
    func onCompletion(_ sequenceCompletion: @escaping (() -> Void)) -> Self {
        completion = sequenceCompletion
        
        return self
    }
    
    func execute() {
        executeSteps()
    }
    
    fileprivate func executeSteps() {
        if sequence.isEmpty == false {
            let step = sequence.removeFirst()
            step
                .onCompleted {
                    self.executeSteps()
                }
                .execute()
        }
        else {
            completion()
        }
    }
}
