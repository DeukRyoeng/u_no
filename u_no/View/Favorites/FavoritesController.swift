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
    
    private let favoritesView = FavoritesView()
    private let disposeBag = DisposeBag()
    
    private let items = BehaviorRelay<[FavoritesItem]>(value: [
        FavoritesItem(leftTopText: "복숭아", leftBottomText: "10개", rightTopText: "23,021원", rightBottomText: "20%"),
        FavoritesItem(leftTopText: "쌀", leftBottomText: "20kg", rightTopText: "51,816원", rightBottomText: "0%"),
        FavoritesItem(leftTopText: "당근", leftBottomText: "1kg", rightTopText: "6,981", rightBottomText: "3.13%")
    ])
    
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
        items.bind(to: favoritesView.items)
            .disposed(by: disposeBag)
    }
}
