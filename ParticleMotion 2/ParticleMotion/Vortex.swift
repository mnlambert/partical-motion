//
//  Vortex.swift
//  ParticleDemo
//
//  Created by Loren Olson on 10/18/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin


class Vortex {
    var center: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var magnitude: Double
    var tightness: Double
    
    init(x: Double, y: Double) {
        center = TVector2(x: x, y: y)
        
        magnitude = 4.0
        tightness = 1.3
        
        velocity = TVector2(x: 1.0, y: 0.5)
        acceleration = TVector2()
    }
    
    func update() {
        velocity = velocity + acceleration
        center = center + velocity
        acceleration = acceleration * 0.0
    }
    
    
    
    func process(p: Particle) {
        // spin the particle around position.
        
        let distance = center.distance(v: p.position)
        var theta = magnitude / pow(distance, tightness)
        
        var thetascale = remap(value: distance, start1: 100.0, stop1: 500.0, start2: 1.0, stop2: 0.0)
        thetascale = constrain(value: thetascale, min: 0.0, max: 1.0)
        theta = theta * thetascale
        
        
        let tmp = p.position - center
        let x = tmp.x * cos(theta) - tmp.y * sin(theta)
        let y = tmp.x * sin(theta) + tmp.y * cos(theta)
        
        p.position = center + TVector2(x: x, y: y)
    }
    
    func render() {
        strokeColor(gray: 1.0)
        fillColor(gray: 0.1)
        ellipse(centerX: center.x, centerY: center.y, width: 20.0, height: 20.0)
    }
    
}
