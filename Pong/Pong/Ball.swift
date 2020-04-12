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
        self.addChild(shape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
