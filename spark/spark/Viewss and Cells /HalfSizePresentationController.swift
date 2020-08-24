import UIKit
class HalfSizePresentationController: UIPresentationController {
    override var frameOfPresentedViewInContainerView: CGRect {
        get {
            return CGRect(x: 0, y: (containerView?.bounds.height ?? 0) * 0.35, width: containerView?.bounds.width ?? 0, height: (containerView?.bounds.height ?? 0))
        }
    }
}
