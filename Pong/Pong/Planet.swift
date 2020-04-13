//
//  Planet.swift
//  Pong
//
//  Created by Natália Struharová on 13/04/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import Foundation
import SpriteKit

class Planet: SKNode {
    
    override init() {
        super.init()
        
        let radius = CGFloat.random(in: 20...100)
        let shape = SKShapeNode(circleOfRadius: radius)
        shape.fillColor = UIColor.red
        
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        
        addChild(shape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
