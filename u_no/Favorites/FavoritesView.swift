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

    private let disposeBag = DisposeBag()
    private let viewModel: FavoritesViewModel
    
    let collectionView: UICollectionView
    
    init(viewModel: FavoritesViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 100)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: .zero)
        setupUI()
        configureCollectionView()
        bindCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(50)
            $0.leading.trailing.equalToSuperview().inset(0)
            $0.bottom.equalToSuperview().offset(-10)
        }
    }
    
    private func configureCollectionView() {
        collectionView.register(SwipeableCollectionViewCell.self, forCellWithReuseIdentifier: "FavoritesCell")
        collectionView.rx.setDelegate(self).disposed(by: disposeBag)
        collectionView.backgroundColor = UIColor.mainBackground
    }
    
    private func bindCollectionView() {
        viewModel.items
            .bind(to: collectionView.rx.items(cellIdentifier: "FavoritesCell", cellType: SwipeableCollectionViewCell.self)) { [weak self] index, model, cell in
                cell.configure(leftTopText: model.leftTopText, rightTopText: model.rightTopText, rightBottomText: model.rightBottomText, indexPath: IndexPath(row: index, section: 0))
                cell.delegate = self
            }
            .disposed(by: disposeBag)
    }
}

extension FavoritesView: SwipeableCollectionViewCellDelegate {
    func didSwipeToDelete(at indexPath: IndexPath) {
        viewModel.deleteItem(at: indexPath)
    }
}

extension FavoritesView: UICollectionViewDelegate { }
