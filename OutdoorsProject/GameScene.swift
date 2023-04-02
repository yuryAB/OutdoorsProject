//
//  GameScene.swift
//  OutdoorsProject
//
//  Created by yury antony on 02/04/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // 1. Adicione o objeto da câmera
    private var cameraNode: SKCameraNode!
    
    // 2. Adicione o objeto do background
    private var backgroundNode: SKSpriteNode!
    
    // 3. Crie uma variável de controle para armazenar o estado atual do zoom
    private var isZoomedIn = false
    
    override func didMove(to view: SKView) {
        // Inicialize e configure a câmera
        cameraNode = SKCameraNode()
        self.camera = cameraNode
        self.addChild(cameraNode)
        
        // Inicialize e configure o background
        backgroundNode = SKSpriteNode(imageNamed: "avenue")
        backgroundNode.zPosition = -1
        self.addChild(backgroundNode)
        
        // Ajuste a escala da câmera para corresponder às dimensões do background
        let scaleX = backgroundNode.size.width / view.frame.size.width
        let scaleY = backgroundNode.size.height / view.frame.size.height
        cameraNode.setScale(min(scaleX, scaleY))
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
    }
    
    func touchMoved(toPoint pos : CGPoint) {
    }
    
    func touchUp(atPoint pos : CGPoint) {
    }
    
    override func mouseDown(with event: NSEvent) {
        toggleZoom()
    }
    
    override func mouseDragged(with event: NSEvent) {
    }
    
    override func mouseUp(with event: NSEvent) {
    }
    
    override func keyDown(with event: NSEvent) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    func toggleZoom() {
        if isZoomedIn {
            let zoomOutAction = SKAction.scale(to: 1, duration: 0.5)
            cameraNode.run(zoomOutAction)
        } else {
            let zoomInAction = SKAction.scale(to: 3, duration: 0.5)
            cameraNode.run(zoomInAction)
        }
        isZoomedIn.toggle()
    }
}
