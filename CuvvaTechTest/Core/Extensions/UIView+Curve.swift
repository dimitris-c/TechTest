//
//  Created by Dimitrios Chatzieleftheriou on 18/07/2020.
//  Copyright © 2020 Dimitrios Chatzieleftheriou. All rights reserved.
//

import UIKit

extension UIView {
    func makeBottomCurvedMask(offset: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath()
        
        var point = CGPoint.zero
        path.move(to: point)
        
        point.y = self.bounds.height - offset
        path.addLine(to: point)
        
        var controlPoint = CGPoint.zero
        controlPoint.x = self.bounds.width * 0.5
        controlPoint.y = point.y + offset * 2

        point.x = self.bounds.width
        
        path.addQuadCurve(to: point, controlPoint: controlPoint)
        
        point.y = 0
        path.addLine(to: point)
        path.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        return maskLayer
    }
}
