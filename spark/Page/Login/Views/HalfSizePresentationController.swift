//
//  HalfSizePresentationController.swift
//  spark
//
//  Created by Hugo Zhan on 2/5/21.
//  Copyright © 2021 Joseph Yeh. All rights reserved.
//

import UIKit

class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            return CGRect(x: 0, y: (containerView?.bounds.height ?? 0) * 0.35, width: containerView?.bounds.width ?? 0, height: (containerView?.bounds.height ?? 0))
        }
    }
}
