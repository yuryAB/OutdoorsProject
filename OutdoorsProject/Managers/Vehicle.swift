//
//  Vehicle.swift
//  OutdoorsProject
//
//  Created by yury antony on 02/04/23.
//

import SpriteKit

class Vehicle: SKSpriteNode {
    enum VehicleState {
        case moving, accelerating, braking, stopped
    }
    
    var state: VehicleState = .stopped {
        didSet {
            updateAppearance()
        }
    }
    
    init() {
        let texture = SKTexture(imageNamed: "car")
        super.init(texture: texture, color: .clear, size: texture.size())
        updateAppearance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateAppearance() {
        switch state {
        case .moving:
            color = .blue
        case .accelerating:
            color = .green
        case .braking:
            color = .yellow
        case .stopped:
            color = .gray
        }
    }
    
    func moveVertically(speed: CGFloat, direction: CGFloat, maxY: CGFloat, minY: CGFloat) {
        let moveAction = SKAction.customAction(withDuration: 1) { [weak self] (_, _) in
            guard let `self` = self else { return }
            self.position.y += speed * direction

            if self.position.y > maxY || self.position.y < minY {
                self.removeFromParent()
            }
        }
        let repeatForeverAction = SKAction.repeatForever(moveAction)
        run(repeatForeverAction)
    }
    
    func accelerate() {
        state = .accelerating
        // Adicione aqui o código para acelerar o veículo
    }
    
    func brake() {
        state = .braking
        // Adicione aqui o código para frear o veículo
    }
    
    func stop() {
        state = .stopped
        // Adicione aqui o código para parar o veículo
    }
}
