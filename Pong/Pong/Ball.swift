//
//  Ball.swift
//  Pong
//
//  Created by Thijs Nulle on 12/04/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import SpriteKit

class Ball: SKNode {
    
    private var shape: SKShapeNode?
    
    override init() {
        super.init()
        
        let shape = SKShapeNode(circleOfRadius: 10)
        shape.lineWidth = 2
        self.shape = shape
        
        self.physicsBody = SKPhysicsBody(circleOfRadius: 10)
//        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 0b0
        self.physicsBody?.contactTestBitMask = 0b1
        
        self.addChild(shape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
