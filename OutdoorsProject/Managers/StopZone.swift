//
//  StopZone.swift
//  OutdoorsProject
//
//  Created by yury antony on 03/04/23.
//

import SpriteKit

class StopZone: SKSpriteNode {
    
    init(size: CGSize) {
        let color = SKColor.black.withAlphaComponent(0.01)
        super.init(texture: nil, color: color, size: size)
        isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
