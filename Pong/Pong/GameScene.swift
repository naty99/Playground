//
//  GameScene.swift
//  Pong
//
//  Created by Natália Struharová on 12/04/2020.
//  Copyright © 2020 Bleach. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var curBar: Bar = Bar()
    private var bar2: Bar = Bar()
    private var ball: Ball = Ball()
    
    override func sceneDidLoad() {

        self.backgroundColor = SKColor.init(displayP3Red: 0.085, green: 0.085, blue: 0.113, alpha: 1)
        
        curBar.position = CGPoint(x: 0, y: -self.frame.height / 2 + 100)
        self.addChild(curBar)
        self.addChild(ball)
        
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
        for t in touches {
            self.touchMoved(toPoint: t.location(in: self))
            let x = (t.location(in: self).x < -self.frame.width / 2 + 150) ?
                -self.frame.width / 2 + 150 :
                (t.location(in: self).x > self.frame.width / 2 - 150) ?
                self.frame.width / 2 - 150 : t.location(in: self).x
            curBar.position.x = x
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {                
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }
}
