//
//  Opponent.swift
//  Pong
//
//  Created by Thijs Nulle on 13/04/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import SpriteKit

class Opponent {
    
    private var bar: Bar = Bar()
    private var speed: CGFloat
    
    init(_ speed: CGFloat) {
        self.speed = speed
    }
    
    func setPosition(pos: CGPoint) {
        self.bar.position = pos
    }
    
    func getBar() -> Bar {
        return self.bar
    }
    
    func update(ball: SKNode) {
        let diff = ball.position.x - self.bar.position.x
        var trans: CGFloat
        if (diff < 0) {
            trans = (diff > -speed) ? diff : -speed
        } else {
            trans = (diff < speed) ? diff : speed
        }
        
//        if (t.location(in: self).x < -self.frame.width / 2 + w) { x = -self.frame.width / 2 + w }
//        else if (t.location(in: self).x > self.frame.width / 2 - w) { x = self.frame.width / 2 - w }
//        else { x = t.location(in: self).x }
//        bar.position.x = x
        
        self.bar.position = self.bar.position.applying(CGAffineTransform(translationX: trans, y: 0))
        self.bar.position.x = (self.bar.position.x < -self.bar.scene!.frame.width / 2 + self.bar.getWidth()) ?
            -self.bar.scene!.frame.width / 2 + self.bar.getWidth() : self.bar.position.x
        self.bar.position.x = (self.bar.position.x > self.bar.scene!.frame.width / 2 - self.bar.getWidth()) ?
            self.bar.scene!.frame.width / 2 - self.bar.getWidth() : self.bar.position.x
    }
    
}
