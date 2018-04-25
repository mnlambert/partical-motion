//
//  ViewController.swift
//  ParticleSystem
//
//
//
// The Nature of Code
// Daniel Shiffman
// http://natureofcode.com

import Cocoa
import Tin
import GameplayKit

class ViewController: TController {
    
    var scene: Scene!
    
    override func viewWillAppear() {
        view.window?.title = "Particle Motion"
        makeView(width: 1200.0, height: 600.0)
        scene = Scene()
        present(scene: scene)
        scene.view?.showStats = false
    }
    
    
    override func mouseUp(with event: NSEvent) {
        print("mouseUp at \(tin.mouseX),\(tin.mouseY)")
        scene.mousePressed()
        //scene.mouseDragged()
    }
    
    override func keyUp(with event: NSEvent) {
        scene.keyPressed()
    }
    
}


class Scene: TScene {
    
    var systems: [ParticleSystem] = []
    var vortex: Vortex = Vortex(x: 0.0, y: 0.0)
    var logo: TImage!
    
    //Perlin Noise***************************************************
    var randomCounts: [Int] = []
    var randomizer = GKGaussianDistribution(lowestValue: 0, highestValue: 1000)
    //*****************************************************************
    
    override func setup() {
        logo = TImage(contentsOfFileInBundle: "treeInGlass.jpg")
        logo.loadPixels()
        
        //Perlin Noise*************
        for _ in 0...20 {
            randomCounts.append(0)
        }
        //**************************
    }
    
    override func update() {
        background(gray: 1.0)
        
        vortex.update()
        vortex.render()
        
        for ps in systems {
            for _ in 1...10 {
                ps.addParticle()
            }
            ps.applyVortex(v: vortex)
            ps.run()
        }
        
        //image(image: logo, x: 0, y: 0) //--> Produces the image in the background
        
        //Perlin Noise***************************************************************
        // To speed up the process, ask for multiple random numbers each frame.
        for _ in 0..<randomCounts.count {
            // Get the next random number, multiple it times the number of bins, then convert to an Int.
            let index = Int(randomizer.nextUniform() * Float(randomCounts.count))
            
            // Increment the bin by one.
            if index >= 0 && index < randomCounts.count {
                randomCounts[index] += 1
            }
        }
        
        // Draw a bar chart of all the bin values.
        let w = 1200.0 / Double(randomCounts.count)
        let h = 600.0 / Double(randomCounts.count)
        
        for x in 0..<randomCounts.count {
            line(x1: Double(randomCounts[x]) * w, y1: Double(randomCounts[x]) + h, x2: Double(randomCounts[x]) * 0.1, y2: Double(randomCounts[x]) * 0.1)
            //rect(x: Double(x) * w, y: 0.0, width: w, height: Double(randomCounts[x]) * 0.1)
        }
        //************************************************************************************
        
        
    }
    
    
    func mousePressed() {
        let ps = ParticleSystem(positon: TVector2(x: tin.mouseX, y: tin.mouseY), generator: logo)
        systems.append(ps)
        
        //Not used on the Particle Motion Assignment
        //ps.style = .sprite
        //        if systems.count % 2 == 0 {
        //            ps.style = .confetti
        //        }
    }
    
    func keyPressed() {
        vortex.center = TVector2(x: 0.0, y: 0.0)
    }

}

