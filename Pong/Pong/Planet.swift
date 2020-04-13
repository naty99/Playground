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
        
        let radius: CGFloat = CGFloat.random(in: 20...30)
        let shape = SKShapeNode(circleOfRadius: radius)
        shape.fillColor = UIColor.white
        
        self.physicsBody = SKPhysicsBody.init(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        
        for i in 1...5 {
            let circle = SKShapeNode(circleOfRadius: radius * CGFloat(i))
            self.addChild(circle)
        }
        
        addChild(shape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
