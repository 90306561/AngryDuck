//
//  GameScene.swift
//  AngryDuck - 2
//
//  Created by 90306561 on 2/28/22.
//

import SpriteKit
import GameplayKit
var duck : SKSpriteNode!

class GameScene: SKScene {
var originalDuckPosition : CGPoint?
    var hasGone = false
    override func didMove(to view: SKView) {
        duck = childNode(withName: "duck") as? SKSpriteNode
        duck.physicsBody?.affectedByGravity = false
        originalDuckPosition = duck.position
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasGone{
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchedWhere = nodes(at: touchLocation)
                
                if !touchedWhere.isEmpty {
                    for node in touchedWhere {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == duck {
                                duck.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasGone{
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchedWhere = nodes(at: touchLocation)
                
                if !touchedWhere.isEmpty {
                    for node in touchedWhere {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == duck {
                                duck.position = touchLocation
                            }
                        }
                    }
                }
            }
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !hasGone{
            if let touch = touches.first {
                let touchLocation = touch.location(in: self)
                let touchedWhere = nodes(at: touchLocation)
                
                if !touchedWhere.isEmpty {
                    for node in touchedWhere {
                        if let sprite = node as? SKSpriteNode {
                            if sprite == duck {
                                let dx = -(touchLocation.x - originalDuckPosition!.x)
                                let dy = -(touchLocation.y - originalDuckPosition!.y)
                                let impulse = CGVector(dx: dx, dy: dy)
                                duck.physicsBody?.affectedByGravity = true
                                duck.physicsBody?.applyImpulse(impulse)
                                //duck.physicsBody?.applyAngularImpulse(-0.001)
                                hasGone = true
                            }
                        }
                    }
                }
            }
        }
    }
    override func update(_ currentTime: TimeInterval) {
        if let duckVelocity = duck.physicsBody?.velocity, let duckAngleVelocity = duck.physicsBody?.angularVelocity {
            if duckVelocity.dx <= 0 && duckVelocity.dy <= 0 && duckAngleVelocity <= 0 && hasGone{
                duck.position = originalDuckPosition!
                duck.physicsBody?.affectedByGravity = false
                duck.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
                duck.physicsBody?.angularVelocity = 0
                duck.zRotation = 0
                
                hasGone = false
            }
        }
    }
}
