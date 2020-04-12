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
        let shape = SKShapeNode(rectOf: CGSize(width: 100, height: 20), cornerRadius: 10)
        shape.strokeColor = SKColor.white
        self.shape = shape
        super.init()
        self.addChild(shape)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
