//
//  SwipeableCollectionViewCell.swift
//  u_no
//
//  Created by t2023-m0117 on 9/3/24.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

protocol SwipeableCollectionViewCellDelegate: AnyObject {
    func didSwipeToDelete(at indexPath: IndexPath)
}

class SwipeableCollectionViewCell: UICollectionViewCell {

    weak var delegate: SwipeableCollectionViewCellDelegate?
    var disposeBag = DisposeBag()
    var indexPath: IndexPath?
    
    private let shadowContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowOpacity = 0.4
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let leftTopLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        label.textColor = .black
        return label
    }()
    
    private let rightTopLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = UIColor(red: 75/255.0, green: 166/255.0, blue: 251/255.0, alpha: 1.0)
        return label
    }()
    
    private let rightBottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label // Set color in configure method
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.layer.cornerRadius = 16
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setupUI()
        setupSwipeGesture()
        setupDeleteAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        deleteButton.isHidden = true
        rightTopLabel.transform = .identity
        rightBottomLabel.transform = .identity
    }
    
    private func setupUI() {
        addSubview(shadowContainerView)
        shadowContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        [leftTopLabel, rightTopLabel, rightBottomLabel, deleteButton].forEach { self.addSubview($0)}
        
        leftTopLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10)
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(150)
            $0.height.equalTo(70)
        }
        
        rightTopLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalTo(leftTopLabel.snp.centerY)
        }
        
        rightBottomLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.top.equalTo(rightTopLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        deleteButton.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.height.equalToSuperview()
            $0.trailing.equalToSuperview()
            $0.top.equalToSuperview()
        }
    }
    
    private func setupSwipeGesture() {
        let leftSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        leftSwipeGesture.direction = .left
        self.addGestureRecognizer(leftSwipeGesture)
        
        let rightSwipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        rightSwipeGesture.direction = .right
        self.addGestureRecognizer(rightSwipeGesture)
    }
    
    private func setupDeleteAction() {
        deleteButton.rx.tap
            .compactMap { self.indexPath }
            .bind { [weak self] indexPath in
                self?.delegate?.didSwipeToDelete(at: indexPath)
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        let translationX: CGFloat = gesture.direction == .left ? -100 : 0
        
        UIView.animate(withDuration: 0.3) {
            self.rightTopLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
            self.rightBottomLabel.transform = CGAffineTransform(translationX: translationX, y: 0)
        }
        
        deleteButton.isHidden = (gesture.direction == .right)
    }
    
    func configure(leftTopText: String, rightTopText: String, rightBottomText: String, indexPath: IndexPath, priceColor: UIColor, fluctuationColor: UIColor) {
        leftTopLabel.text = leftTopText
        rightTopLabel.text = rightTopText
        rightBottomLabel.text = rightBottomText
        self.indexPath = indexPath
        
        // Set label colors based on the direction color
        rightTopLabel.textColor = priceColor
        rightBottomLabel.textColor = fluctuationColor
    }
}
