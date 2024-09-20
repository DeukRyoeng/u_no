//
//  FavoritesController.swift
//  u_no
//
//  Created by t2023-m0117 on 9/2/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class FavoritesController: UIViewController {

    private let disposeBag = DisposeBag()
    private let viewModel = FavoritesViewModel()
    private lazy var favoritesView = FavoritesView(viewModel: viewModel)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        setupUI()
        bindData()
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadData()
    }

    private func setupUI() {
        view.addSubview(favoritesView)
        favoritesView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func bindData() {
        viewModel.itemDeleted
            .subscribe(onNext: { indexPath in
                print("Deleted item at: \(indexPath)")
            })
            .disposed(by: disposeBag)
        
        favoritesView.collectionView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let self = self else { return }
                
                let selectedItem = self.viewModel.items.value[indexPath.row]
                guard let productno = selectedItem.productno else { return }
                
                let selectedPrice = self.viewModel.favoritePrices.value.first { $0.productno == productno }
                
                if let price = selectedPrice {
                    let graphViewController = GraphViewController()
                    graphViewController.nameData = [price]
                    self.present(graphViewController, animated: true, completion: nil)
                }
            })
            .disposed(by: disposeBag)
    }
}
