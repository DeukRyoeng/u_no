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
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25) 
        button.contentHorizontalAlignment = .left
        button.frame.size = CGSize(width: 200, height: 60)
        return button
    }()

    private let priceDecreaseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시세하락", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        button.contentHorizontalAlignment = .left
        button.frame.size = CGSize(width: 200, height: 60)
        return button
    }()

    
    var onFilterSelected: ((Bool) -> Void)?
    var isPriceIncrease: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupButtons()
        setupBindings()
        updateButtonStates()
    }
    
    private func setupButtons() {
        let stackView = UIStackView(arrangedSubviews: [priceIncreaseButton, priceDecreaseButton])
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().inset(20)

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
    
    private func updateButtonStates() {
        let checkmarkImage = UIImage(systemName: "checkmark")?.withRenderingMode(.alwaysTemplate)
        
        if isPriceIncrease {
            priceIncreaseButton.setImage(checkmarkImage, for: .normal)
            priceIncreaseButton.tintColor = UIColor.mainBlue
            priceDecreaseButton.setImage(nil, for: .normal)
            priceIncreaseButton.setTitleColor(UIColor.mainBlue, for: .normal)
            priceDecreaseButton.setTitleColor(.black, for: .normal)
        } else {
            priceIncreaseButton.setImage(nil, for: .normal)
            priceDecreaseButton.setImage(checkmarkImage, for: .normal)
            priceDecreaseButton.tintColor = UIColor.mainBlue
            priceIncreaseButton.setTitleColor(.black, for: .normal)
            priceDecreaseButton.setTitleColor(UIColor.mainBlue, for: .normal)
        }
        
        // Align checkmark image to the right
        priceIncreaseButton.semanticContentAttribute = .forceRightToLeft
        priceDecreaseButton.semanticContentAttribute = .forceRightToLeft
    }

}
