//
//  Particle.swift
//  ParticleSystem
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com


import Foundation
import Tin


class Particle: Equatable {
    var position: TVector2
    var velocity: TVector2
    var acceleration: TVector2
    var lifespan: Double //How long does this particle live, in frames.
    var age: Double //How old is the particle.
    var mass: Double
    var fill: TColor
    
    
    init(location: TVector2) {
        
        position = location
        velocity = TVector2(x: randomGaussian(), y: randomGaussian())
        velocity.normalize() //Every particle's velocity has a magnitude of 1
        acceleration = TVector2(x: 0.0, y: 0.0)
        lifespan = 2000.0 + randomGaussian() * 20//Live 200 frames. Sometimes it is not good to have the same lifespan
        //lifespan = 200.0 //Live 200 frames.
        age = 0.0
        mass = 1.0
        fill = TColor(red: 1, green: 1, blue: 1, alpha: 0)
    }
    
    
    func run() {
        update()
        display()
    }
    
    
    func update() {
        velocity = velocity + acceleration
        position = position + velocity
        acceleration = acceleration * 0.0
        lifespan -= 1.0
        age += 1
    }
    
    
    func applyForce(force: TVector2) {
        acceleration = acceleration + force / mass
    }
    
    
    func display() {
        var a = remap(value: age, start1: lifespan - 60.0, stop1: lifespan, start2: 1.0, stop2: 0.0)
        constrain(value: a, min: 0.0, max: 1.0)
        //let a = 1.0 - (age / lifespan)
        strokeColor(gray: 0.0, alpha: a)
        lineWidth(2.0)
        strokeDisable()
        fill.alpha = a
        fillColor(red: fill.red, green: fill.green, blue: fill.blue, alpha: a)
        //fillColor(gray: 0.5, alpha: a)
        ellipse(centerX: position.x, centerY: position.y, width: 6.0, height: 6.0)
        //The rectangle renders faster when it is small vs making an ellipse small.
    }
    
    
    func isDead() -> Bool {
        if lifespan < 0.0 {
            return true
        }
        else {
            return false
        }
    }
    
    
    // Equatable
    
    // So... Apple docs say equatable != identity
    // nevertheless, giving this a try.
    static func == (lhs: Particle, rhs: Particle) -> Bool {
        return lhs === rhs
    }
    
}
