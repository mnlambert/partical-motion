//
//  Sprite.swift
//  ParticleMotion
//
//  Created by student on 10/25/17.
//  Copyright © 2017 ASU. All rights reserved.
//

import Foundation
import Tin

class Sprite: Particle {
    //When drawing an image make it small enough for the run not to eplode and waste time. 
    var img: TImage?
    
    init(location: TVector2, image: TImage?) {
        super.init(location: location)
        img = image
    }
    
    
    override func display() {
        var a = remap(value: age, start1: lifespan - 60.0, stop1: lifespan, start2: 1.0, stop2: 0.0)
        a = constrain(value: a, min: 0.0, max: 1.0)
        if let img = img {
            setAlpha(a)
            image(image: img, x: position.x - 6.0, y: position.y - 6.0, width: 12.0, height: 12.0)
        }
    }
}
