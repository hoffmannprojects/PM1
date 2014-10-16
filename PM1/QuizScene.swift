//
//  QuizScene.swift
//  PM1
//
//  Created by Moritz Kuentzler on 16/10/2014.
//  Copyright (c) 2014 PM Productions. All rights reserved.
//

import Foundation
import SpriteKit

class QuizScene: SKScene {
    var tick:(())?
    var tickLengthMillis = NSTimeInterval(600)
    var lastTick:NSDate?
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if lastTick == nil {
            return
        }
        
        var timePassed = lastTick!.timeIntervalSinceNow * -1000.0
        println(timePassed)
        if timePassed > tickLengthMillis {
            lastTick = NSDate.date()
            println("ka")
            tick?
        }
    }
    
    func startTicking() {
        lastTick = NSDate.date()
    }
    
    func stopTicking() {
        lastTick = nil
    }
    
    func debugFunc() -> () {
        println("yo")
        return
    }
}