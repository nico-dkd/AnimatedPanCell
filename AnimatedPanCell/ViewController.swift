//
//  ViewController.swift
//  AnimatedPanView
//
//  Created by Nico Lassen on 20.06.19.
//  Copyright © 2019 Nico Lassen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var cells = [String: UIView]()
    let numberOfColums = 15
    var selectedCell: UIView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
        
        createViews()
    }
    
    @objc func handlePan(_ gesture: UIPanGestureRecognizer) {
        
        let width = view.frame.width / 15
        
        let location = gesture.location(in: view)
        print("x:\(Int(location.x))|y:\(Int(location.y))")
        
        let x = Int(location.x) / Int(width)
        let y = Int(location.y) / Int(width)
        
        let key = "x:\(x)|y:\(y)"
        
        guard let view = cells[key] else { return }
        
        let touchDidEnd = gesture.state == .ended
        runAnimation(for: view, didEnd: touchDidEnd)
    }
    
    private func runAnimation(for view: UIView, didEnd: Bool) {
        
        print(didEnd)
        if selectedCell != view || didEnd {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                self.selectedCell?.layer.transform = CATransform3DIdentity
                
            }, completion: nil)
        }
        
        self.view.bringSubviewToFront(view)
        
        if !didEnd {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                view.layer.transform = CATransform3DMakeScale(3, 3, 3)
            }, completion: nil)
        }
        
        selectedCell = view
    }
    
    private func createViews() {
        
        let width = view.frame.width / 15
        
        for j in 0...35 {
            for i in 0...numberOfColums {
                
                let randomRed = CGFloat(drand48())
                let randomGreen = CGFloat(drand48())
                let randomBlue = CGFloat(drand48())
                
                let colorForView = UIColor(displayP3Red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1)
                
                let coloredView = UIView(frame: CGRect(origin: CGPoint(x: (i * Int(width)), y: (j * Int(width))), size: CGSize(width: width, height: width)))
                
                coloredView.backgroundColor = colorForView
                
                view.addSubview(coloredView)
                
                let key = "x:\(i)|y:\(j)"
                
                cells[key] = coloredView
            }
        }
    }
}

