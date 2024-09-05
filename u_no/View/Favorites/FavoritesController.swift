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
        view.backgroundColor = UIColor(red: 245/255.0, green: 247/255.0, blue: 248/255.0, alpha: 1.0)
        setupUI()
        bindData()
    }
    
    private func setupUI() {
        view.addSubview(favoritesView)
        favoritesView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func bindData() {
        viewModel.itemDeleted.subscribe(onNext: { indexPath in
        }).disposed(by: disposeBag)
    }
}
