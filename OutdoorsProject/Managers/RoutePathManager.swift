//
//  RoutePathManager.swift
//  OutdoorsProject
//
//  Created by yury antony on 02/04/23.
//

import Foundation
import SpriteKit

class RoutePathManager {
    //MARK: rotas retas
    static let path1 = [
        CGPoint(x: 290, y: -1876),
        CGPoint(x: 290, y: 1876)
    ]
    static let path2 = [
        CGPoint(x: 190, y: -1876),
        CGPoint(x: 190, y: 1876)
    ]
    static let path3 = [
        CGPoint(x: 90, y: -1876),
        CGPoint(x: 90, y: 1876)
    ]
    static let path4 = [
        CGPoint(x: -60, y: 1876),
        CGPoint(x: -60, y: -1876)
    ]
    static let path5 = [
        CGPoint(x: -160, y: 1876),
        CGPoint(x: -160, y: -1876)
    ]
    static let path6 = [
        CGPoint(x: -260, y: 1876),
        CGPoint(x: -260, y: -1876)
    ]
    
    static let allPaths:[[CGPoint]] = [
        path1,path2,
        path3,path4,
        path5,path6
    ]
}
