//
//  ConfirmationViewController.swift
//  u_no
//
//  Created by t2023-m0117 on 9/5/24.
// test

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class ConfirmationViewController: UIViewController {
    
    private let titleUnderlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let subLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 247/255, green: 63/255, blue: 63/255, alpha: 1)
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let disposeBag = DisposeBag()
    private let actionHandler: () -> Void
    
    // Custom initializer
    init(title: String, description: String, sub: String, actionButtonText: String, actionHandler: @escaping () -> Void) {
        self.actionHandler = actionHandler
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        descriptionLabel.text = description
        subLable.text = sub
        actionButton.setTitle(actionButtonText, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindActions() 
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        
        // Create a stack view to hold the buttons horizontally
        let buttonStackView = UIStackView(arrangedSubviews: [cancelButton, actionButton])
        buttonStackView.axis = .horizontal
        buttonStackView.distribution = .fillEqually
        buttonStackView.spacing = 10

        [titleUnderlineView, titleLabel, descriptionLabel, subLable, buttonStackView].forEach { view.addSubview($0) }
        
        titleUnderlineView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(0)
            $0.leading.equalToSuperview().inset(0)
            $0.trailing.equalToSuperview().inset(0)
            $0.height.equalTo(70)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.centerX.equalToSuperview()
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        subLable.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview().inset(60)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44) // Set uniform height for the buttons
        }
    }

    
    private func bindActions() {
        // Bind cancelButton tap to dismiss modal
        cancelButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        // Bind actionButton tap to perform action and dismiss modal
        actionButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.actionHandler()
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
