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
    
    func isCollisionImminent(with vehicles: [Vehicle]) -> Bool {
        let detectionDistance: CGFloat = 30.0
        let detectionRect = CGRect(x: position.x - size.width / 2, y: position.y - size.height / 2, width: size.width, height: size.height + detectionDistance)

        for vehicle in vehicles {
            if vehicle != self && detectionRect.intersects(vehicle.frame) {
                return true
            }
        }
        return false
    }
    
    func moveVertically(direction: CGFloat, maxY: CGFloat, minY: CGFloat, allVehicles: [Vehicle]) {
        let moveAction = SKAction.customAction(withDuration: 1) { [weak self] (_, _) in
            guard let `self` = self else { return }

            self.position.y += self.speed * direction

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
