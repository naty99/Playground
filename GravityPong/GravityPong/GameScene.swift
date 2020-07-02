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
    private var ball : Ball?
    
    override func sceneDidLoad() {
        setupPhysics()
        createElements()
        initialisePlayers()
    }
    
    func touchDown(atPoint pos : CGPoint) {}
            
    func touchMoved(toPoint pos : CGPoint) {}
    
    func touchUp(atPoint pos : CGPoint) {}
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {}
        
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {}
    
    override func update(_ currentTime: TimeInterval) {}
    
    func setupPhysics() {
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        self.physicsBody?.affectedByGravity = false;
    }
    
    func initialisePlayers() {
        player = Bar()
        
        addChild(player!)
        // Called before each frame is rendered
    }
    
    private func createElements() {
        ball = Ball(position: CGPoint(x: 0.0, y: 0.0), speed: 0.0, radius: 15.0)
        self.addChild(ball!)
    }

}
