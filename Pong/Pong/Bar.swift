//
//  Bar.swift
//  Pong
//
//  Created by Natália Struharová on 12/04/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import Foundation
import SpriteKit

class Bar: SKNode {
    private var shape: SKShapeNode?
    
    override init() {
        super.init()
        
        let shape = SKShapeNode(rectOf: CGSize(width: 150, height: 20), cornerRadius: 5)
        shape.lineWidth = 2
        self.shape = shape
        
        self.physicsBody = SKPhysicsBody(rectangleOf: (self.shape?.frame.size)!)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 0b1
        self.physicsBody?.contactTestBitMask = 0b0
        
        
        self.addChild(shape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
