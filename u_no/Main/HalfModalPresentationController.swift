//
//  HalfModalPresentationController.swift
//  u_no
//
//  Created by t2023-m0117 on 9/19/24.
//

import UIKit

class HalfModalPresentationController: UIPresentationController {
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let height = containerView.bounds.height * 0.2
        return CGRect(x: 0, y: containerView.bounds.height - height, width: containerView.bounds.width, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        presentedView?.layer.cornerRadius = 12
        presentedView?.clipsToBounds = true
        presentedView?.backgroundColor = .white
    }
}
