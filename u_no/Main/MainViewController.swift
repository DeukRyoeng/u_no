//
//  MainViewController.swift
//  u_no
//
//  Created by 이득령 on 8/29/24.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class MainViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private let mainVM = MainViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            if sectionIndex == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(110))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(330))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]
                
                return section
            } else if sectionIndex == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0 / 3.0), heightDimension: .absolute(110))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 5, bottom: 10, trailing: 5)

                let horizontalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(110))
                let horizontalGroup = NSCollectionLayoutGroup.horizontal(layoutSize: horizontalGroupSize, subitems: [item, item, item])
                
                let verticalGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(220))
                let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: verticalGroupSize, subitems: [horizontalGroup, horizontalGroup])

                let section = NSCollectionLayoutSection(group: verticalGroup)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)

                let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
                let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
                section.boundarySupplementaryItems = [header]

                return section
            }

            return nil
        }
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var isPriceIncrease: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        setupCollectionView()
        bindCollectionView()
        mainVM.fetchAllData()
    }

    private func bindCollectionView() {
        updateCollectionViewBasedOnFilter()
    }
    
    private func updateCollectionViewBasedOnFilter() {
        collectionView.delegate = nil
        collectionView.dataSource = nil

        let dataSource = RxCollectionViewSectionedReloadDataSource<SectionModel<String, Price>>(
            configureCell: { (dataSource, collectionView, indexPath, item) -> UICollectionViewCell in
                if indexPath.section == 0 {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewFirstCell.id, for: indexPath) as? MainViewFirstCell else {
                        return UICollectionViewCell()
                    }
                    let isRising = self.isPriceIncrease && item.value.asString() != "0"
                    cell.configure(with: item, isRising: isRising)
                    return cell
                } else {
                    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewSecoundCell.id, for: indexPath) as? MainViewSecoundCell else {
                        return UICollectionViewCell()
                    }
                    cell.configure(with: item)
                    return cell
                }
            },
            configureSupplementaryView: { dataSource, collectionView, kind, indexPath in
                guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MainSectionHeaderView.id, for: indexPath) as? MainSectionHeaderView else {
                    return UICollectionReusableView()
                }

                if indexPath.section == 0 {
                    header.configure(with: self.isPriceIncrease ? "Top3: 시세상승" : "Top3: 시세하락", isFavoriteHeader: true)
                } else if indexPath.section == 1 {
                    header.configure(with: "즐겨찾기 항목", isFavoriteHeader: false)
                }
                header.priceButton.rx.tap
                    .bind { [weak self] in
                        self?.showPriceFilter() // Call the method to show the price filter
                    }
                    .disposed(by: self.disposeBag)

                return header
            }
        )

        let top3PricesObservable = self.isPriceIncrease ? mainVM.top3RisingPrices : mainVM.top3FallingPrices
        let favoritePricesObservable = mainVM.favoritePrices

        Observable.combineLatest(top3PricesObservable, favoritePricesObservable)
            .map { top3Prices, favoritePrices in
                let limitedFavorites = Array(favoritePrices.prefix(6))
                return [
                    SectionModel(model: "Top3", items: top3Prices),
                    SectionModel(model: "즐겨찾기 항목", items: limitedFavorites)
                ]
            }
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

        collectionView.delegate = self
    }

    private func setupCollectionView() {
        collectionView.register(MainViewFirstCell.self, forCellWithReuseIdentifier: MainViewFirstCell.id)
        collectionView.register(MainViewSecoundCell.self, forCellWithReuseIdentifier: MainViewSecoundCell.id)
        collectionView.register(MainSectionHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MainSectionHeaderView.id)
        collectionView.backgroundColor = UIColor.mainBackground
        collectionView.isScrollEnabled = true

        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func showPriceFilter() {
        let priceFilterVC = PriceFilterViewController()
        priceFilterVC.onFilterSelected = { [weak self] isIncreasing in
            self?.isPriceIncrease = isIncreasing
            self?.updateCollectionViewBasedOnFilter() // Rebind collection view data based on selected filter
        }
        priceFilterVC.isPriceIncrease = isPriceIncrease // Pass the current filter state
        priceFilterVC.modalPresentationStyle = .custom
        priceFilterVC.transitioningDelegate = self
        present(priceFilterVC, animated: true, completion: nil)
    }

}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            // Handle Top 3 Section
            let top3PricesObservable = isPriceIncrease ? mainVM.top3RisingPrices : mainVM.top3FallingPrices
            top3PricesObservable
                .take(1)
                .subscribe(onNext: { [weak self] prices in
                    guard let self = self, indexPath.row < prices.count else { return }
                    let selectedPrice = prices[indexPath.row]
                    let graphViewController = GraphViewController()
                    graphViewController.nameData = [selectedPrice]
                    self.present(graphViewController, animated: true, completion: nil)
                })
                .disposed(by: disposeBag)
        } else if indexPath.section == 1 {
            // Handle Favorites Section
            mainVM.favoritePrices
                .take(1)
                .subscribe(onNext: { [weak self] favorites in
                    guard let self = self, indexPath.row < favorites.count else { return }
                    let selectedFavorite = favorites[indexPath.row]
                    let graphViewController = GraphViewController()
                    graphViewController.nameData = [selectedFavorite]
                    self.present(graphViewController, animated: true, completion: nil)
                })
                .disposed(by: disposeBag)
        }
    }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
