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
        let ballPos = ball.position
        let trans = ball.position.x - self.bar.position.x
        self.bar.position = CGPoint(x: trans, y: self.bar.position.y)
    }
    
}
