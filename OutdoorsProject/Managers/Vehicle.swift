//
//  Vehicle.swift
//  OutdoorsProject
//
//  Created by yury antony on 02/04/23.
//

import SpriteKit

class Vehicle: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "car")
        super.init(texture: texture, color: .clear, size: texture.size())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func isCollisionImminent(with stopZones: [StopZone]) -> Bool {
        for stopZone in stopZones {
            if self.frame.intersects(stopZone.frame) {
                return true
            }
        }
        return false
    }
    
    func moveVertically(direction: CGFloat, maxY: CGFloat, minY: CGFloat, allVehicles: [Vehicle],
                        scene: GameScene) {
        let moveAction = SKAction.customAction(withDuration: 1) { [weak self] (_, _) in
            guard let `self` = self else { return }

            if let semaphore = scene.children.first(where: { $0 is Semaphore }) as? Semaphore {
                if !semaphore.isRedLightOn || !self.isCollisionImminent(with: scene.stopZones) {
                    self.position.y += self.speed * direction
                }
            }

            if self.position.y > maxY || self.position.y < minY {
                self.removeFromParent()
            }
        }
        let repeatForeverAction = SKAction.repeatForever(moveAction)
        run(repeatForeverAction)
    }
    
    func accelerate(allVehicles: [Vehicle]) {
    }
    
    func brake() {
    }
    
    func stop() {
    }
}
