//
//  ParticleSystem.swift
//  ParticleDemo
//
//  Created by Loren Olson on 10/11/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin


enum ParticleStyle {
    case normal
    case confetti
    case sprite
}

class ParticleSystem {
    var particles: [Particle]
    var origin: TVector2
    var style: ParticleStyle
    var image: TImage?
    var generatorImgage: TImage
    
    init(positon: TVector2, generator: TImage) {
        origin = positon
        particles = []
        style = .normal
        image = TImage(contentsOfFileInBundle: "flowers.png")
        generatorImgage = generator
    }
    
    
    func addParticle() {
        var x: Double = 0.0
        var y: Double = 0.0
        var point: TVector2
        var c: TColor = TColor(red: 0, green: 0, blue: 0, alpha: 0)
        var stillLooking = true
        while stillLooking {
            //let point = origin
            x = random(max: tin.width)
            y = random(max: tin.height)
            
            //Reject black pixesl.
            c = generatorImgage.color(atX: Int(x), y: Int(y))
            if c.brightness() > 0.1 {
                stillLooking = false
            }
        }
        
        point = TVector2(x: x, y: y)
        
        switch style {
        case .normal:
            let p = Particle(location: point)
            let c = generatorImgage.color(atX: Int(x), y: Int(y))
            p.fill = c
            particles.insert(p, at: 0)
        case .confetti:
            let p = Confetti(location: point)
            particles.insert(p, at: 0)
        case .sprite:
            let p = Sprite(location: point, image: image)
            particles.insert(p, at: 0)
        }
    }
    
    
    func applyForce(force: TVector2) {
        for p in particles {
            p.applyForce(force: force)
        }
    }
    
    func applyVortex(v: Vortex) {
        for p in particles {
            v.process(p: p)
        }
    }
    
    func run() {
        for p in particles {
            p.run()
            if p.isDead() {
                if let i = particles.index(of: p) {
                    particles.remove(at: i)
                }
            }
        }
    }
}
