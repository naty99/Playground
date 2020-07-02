//
//  GameScene.swift
//  GravityPong
//
//  Created by Natália Struharová on 02/07/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var player: Bar?
    
    override func sceneDidLoad() {
        setupPhysics()
        
        initialisePlayers()
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        
    }
    
    func touchUp(atPoint pos : CGPoint) {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    func setupPhysics() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.affectedByGravity = false;
    }
    
    func initialisePlayers() {
        player = Bar()
        
        addChild(player!)
    }

}
