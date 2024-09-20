//
//  PeopleView.swift
//  u_no
//
//  Created by t2023-m0117 on 9/13/24.
//

import UIKit
import SnapKit

class PeopleView: UIView {
    
    private let introduceLabel: UILabel = {
        let label = UILabel()
        label.text = """
           사용자 경험을 최우선으로 생각하며 세심하게 작업했습니다.
           저희의 작은 노력들이 여러분에게 도움이 되길 바랍니다!
           
           개발팀
           """
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.textAlignment = .natural
        label.numberOfLines = 0
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: 120)

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(PeopleCell.self, forCellWithReuseIdentifier: "PeopleCell")
        return collectionView
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        [introduceLabel, separatorLine, collectionView].forEach { self.addSubview($0) }
        
        introduceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(120)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        separatorLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
            $0.bottom.equalToSuperview().offset(-safeAreaInsets.bottom)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(introduceLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(separatorLine.snp.top).offset(-20)
        }
    }
}
