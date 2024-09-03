//
//  FavoritesView.swift
//  u_no
//
//  Created by t2023-m0117 on 9/2/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FavoritesView: UIView {
    
    let items = BehaviorRelay<[FavoritesItem]>(value: [])
    private let disposeBag = DisposeBag()
    
    private let favoritesCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 350, height: 100)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 248/255.0, alpha: 1.0)
        collection.isScrollEnabled = true
        return collection
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        configureCollectionView()
        bindCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(favoritesCollection)
        favoritesCollection.snp.makeConstraints {
            $0.top.equalToSuperview().offset(70)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func configureCollectionView() {
        favoritesCollection.register(SwipeableCollectionViewCell.self, forCellWithReuseIdentifier: "FavoritesCell")
        favoritesCollection.rx.setDelegate(self).disposed(by: disposeBag)
    }
    
    private func bindCollectionView() {
        items.bind(to: favoritesCollection.rx.items(cellIdentifier: "FavoritesCell", cellType: SwipeableCollectionViewCell.self)) { [weak self] index, model, cell in
            cell.configure(leftTopText: model.leftTopText, leftBottomText: model.leftBottomText, rightTopText: model.rightTopText, rightBottomText: model.rightBottomText, indexPath: IndexPath(row: index, section: 0))
            
            // Set delegate to handle delete action
            cell.delegate = self
            
        }.disposed(by: disposeBag)
    }
    
    private func handleDelete(at indexPath: IndexPath) {
        var currentItems = items.value
        
        guard indexPath.row < currentItems.count else {
            print("Index out of range, no item to delete.")
            return
        }
        
        currentItems.remove(at: indexPath.row)
        items.accept(currentItems)
    }
}

extension FavoritesView: SwipeableCollectionViewCellDelegate {
    func didSwipeToDelete(at indexPath: IndexPath) {
        handleDelete(at: indexPath)
    }
}

extension FavoritesView: UICollectionViewDelegate {
    // Implement delegate methods if needed
}
