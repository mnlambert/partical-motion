//
//  Confetti.swift
//  ParticleDemo
//
//  Created by Loren Olson on 10/16/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin


class Confetti: Particle {
    
    
    override func display() {
        let theta = remap(value: position.y, start1: 0, stop1: tin.height, start2: 0.0, stop2: -Double.pi * 4.0)
        let a = lifespan / 255.0
        pushState()
        translate(dx: position.x, dy: position.y)
        rotate(by: theta)
        strokeColor(gray: 0.0, alpha: a)
        lineWidth(2.0)
        fillColor(gray: 0.5, alpha: a)
        rect(x: -6.0, y: -6.0, width: 12.0, height: 12.0)
        popState()
    }
    
    
}
