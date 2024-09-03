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
    var indexPath: IndexPath? // Store the index path
    
    private let leftTopLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        return label
    }()
    
    private let leftBottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .white
        return label
    }()
    
    private let rightTopLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textColor = UIColor(red: 75/255.0, green: 166/255.0, blue: 251/255.0, alpha: 1.0)
        return label
    }()
    
    private let rightBottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor(red: 75/255.0, green: 166/255.0, blue: 251/255.0, alpha: 1.0)
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.isHidden = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.black.cgColor
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 4
    }
    
    private func setupUI() {
        [leftTopLabel, leftBottomLabel, rightTopLabel, rightBottomLabel, deleteButton].forEach { self.addSubview($0) }
        
        leftTopLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalToSuperview().offset(5)
        }
        
        leftBottomLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.top.equalTo(leftTopLabel.snp.bottom).offset(4)
            $0.bottom.equalToSuperview().offset(-10)
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
            .compactMap { self.indexPath } // Ensure indexPath is not nil
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
    
    func configure(leftTopText: String, leftBottomText: String, rightTopText: String, rightBottomText: String, indexPath: IndexPath) {
        leftTopLabel.text = leftTopText
        leftBottomLabel.text = leftBottomText
        rightTopLabel.text = rightTopText
        rightBottomLabel.text = rightBottomText
        self.indexPath = indexPath
    }
}
