//
//  Bar.swift
//  GravityPong
//
//  Created by Natália Struharová on 02/07/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import Foundation
import SpriteKit

class Bar: SKNode {
    
	private var shape: SKShapeNode?
    private var size: CGSize = CGSize(width: 125, height: 25)
    
    override init() {
        super.init();
        
        self.shape = SKShapeNode(rectOf: size, cornerRadius: 10);
        shape?.lineWidth = 4.0
        
        setupPhysics()
        
        self.addChild(shape!)
                        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupPhysics() {
        self.physicsBody = SKPhysicsBody(rectangleOf: size)
        self.physicsBody?.affectedByGravity = false; 
    }
    
    
}


