//
//  DrawView.swift
//  simpleDraw
//
//  Created by Dor Rubin on 10/15/16.
//  Copyright © 2016 Dor Rubin. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var lines: [Line] = []
    var lastPoint: CGPoint!
    
    required init(coder aDecoder: (NSCoder!)) {
        super.init(coder: aDecoder)!
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            //The view you would like to get the tap location from.
            lastPoint = touch.locationInView(self)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            //The view you would like to get the tap location from.
            let newPoint = touch.locationInView(self)
            lines.append(Line(start: lastPoint, end: newPoint))
            lastPoint = newPoint
            self.setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        CGContextBeginPath(context)
        for line in lines {
            CGContextMoveToPoint(context, line.start.x, line.start.y)
            CGContextAddLineToPoint(context, line.end.x, line.end.y)
        }
        CGContextSetLineCap(context, CGLineCap.Round) //rounded
        CGContextSetRGBStrokeColor(context, 0, 0, 0, 1) //black
        CGContextSetLineWidth(context, 5) // 5px
        CGContextStrokePath(context) //must be done last
    }
    
}
