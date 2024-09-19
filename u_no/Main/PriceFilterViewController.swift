//
//  PriceFilterViewController.swift
//  u_no
//
//  Created by t2023-m0117 on 9/19/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PriceFilterViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    
    private let priceIncreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시세상승", for: .normal)
        return button
    }()
    
    private let priceDecreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시세하락", for: .normal)
        return button
    }()
    
    var onFilterSelected: ((Bool) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupButtons()
        setupBindings()
    }
    
    private func setupButtons() {
        let stackView = UIStackView(arrangedSubviews: [priceIncreaseButton, priceDecreaseButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
    private func setupBindings() {
        priceIncreaseButton.rx.tap
            .bind { [weak self] in
                self?.onFilterSelected?(true)
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
        
        priceDecreaseButton.rx.tap
            .bind { [weak self] in
                self?.onFilterSelected?(false)
                self?.dismiss(animated: true, completion: nil)
            }
            .disposed(by: disposeBag)
    }
}
