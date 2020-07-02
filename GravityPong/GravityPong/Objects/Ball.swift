//
//  Ball.swift
//  GravityPong
//
//  Created by Thijs Nulle on 02/07/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import Foundation
import SpriteKit

class Ball: SKNode {
    
    private var radius: CGFloat?
    private var shape: SKShapeNode?
    
    override init() {
        super.init()
        
        self.radius = 15.0
        self.position = CGPoint(x: 0.0, y: 0.0)
        self.speed = 0.0
    }
    
    convenience init(radius: CGFloat) {
        self.init()
        
        self.radius = radius
        self.shape = SKShapeNode(circleOfRadius: self.radius!)
        
        setupPhysics()
        add(node: shape!)
    }
    
    convenience init(radius: CGFloat, position: CGPoint) {
        self.init(radius: radius)
        self.position = position
    }
    
    convenience init(radius: CGFloat, position: CGPoint, speed: CGFloat) {
        self.init(radius: radius, position: position)
        self.speed = speed
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPhysics() {
        self.physicsBody = SKPhysicsBody(circleOfRadius: self.radius!)
        self.physicsBody?.affectedByGravity = false
    }
    
    private func add(node: SKShapeNode) {
        self.add(node: node, width: 5.0)
    }
    
    private func add(node: SKShapeNode, width: CGFloat) {
        self.shape?.lineWidth = width
        
        self.removeAllChildren()
        self.addChild(node)
    }
    
}
