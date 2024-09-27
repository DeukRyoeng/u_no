//
//  HalfModalPresentationController.swift
//  u_no
//
//  Created by t2023-m0117 on 9/19/24.
//

import UIKit
import RxSwift
import RxCocoa

class HalfModalPresentationController: UIPresentationController {
    
    private let disposeBag = DisposeBag()
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0
        return view
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView = containerView else { return .zero }
        let height = containerView.bounds.height * 0.2 // Set modal height to 20% of container height
        return CGRect(x: 0,
                      y: containerView.bounds.height - height, // Position the modal at the bottom
                      width: containerView.bounds.width,
                      height: height)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }
        
        // Add dimming view to the container view
        containerView.addSubview(dimmingView)
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0
        
        // Style the presented view
        presentedView?.layer.cornerRadius = 12
        presentedView?.clipsToBounds = true
        presentedView?.backgroundColor = .white
        
        // Bind the tap gesture for dismissing the modal
        bindDimmingViewTap()
        
        // Animate the dimming view's appearance
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 1
            })
        } else {
            dimmingView.alpha = 1
        }
    }
    
    override func dismissalTransitionWillBegin() {
        // Animate the dimming view's disappearance
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.dimmingView.alpha = 0
            })
        } else {
            dimmingView.alpha = 0
        }
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        dimmingView.frame = containerView?.bounds ?? .zero
    }
    
    private func bindDimmingViewTap() {
        let tapGesture = UITapGestureRecognizer()
        dimmingView.addGestureRecognizer(tapGesture)
        
        tapGesture.rx.event
            .bind { [weak self] _ in
                self?.presentedViewController.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
