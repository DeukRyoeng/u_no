    //
    //  PeopleController.swift
    //  u_no
    //
    //  Created by t2023-m0117 on 9/13/24.
    //

import UIKit

class PeopleController: UIViewController {

    private let peopleView = PeopleView()

    private let peopleData: [(emoji: UIImage, name: String, role: String, intro: String)] = [
        (UIImage(systemName: "person")!, "이득령", "iOS Developer", "Swift를 사랑하는 개발자입니다."),
        (UIImage(systemName: "person")!, "유민우", "iOS Developer", "swift로 세상을 그려나갑니다."),
        (UIImage(systemName: "person")!, "점승현", "iOS Developer", "코드는 예술입니다."),
        (UIImage(systemName: "person")!, "백시훈", "iOS Developer", "문제를 해결하는 개발자입니다.")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.mainBackground
        setupNavigationBar()
        setupView()
        setupCollectionView()
    }

    private func setupNavigationBar() {
        self.title = "만든 사람"
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.white
        appearance.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.black,
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)
        ]

        self.navigationController?.navigationBar.standardAppearance = appearance
    }

    private func setupView() {
        view.addSubview(peopleView)
        peopleView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    private func setupCollectionView() {
        peopleView.collectionView.dataSource = self
        peopleView.collectionView.delegate = self
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension PeopleController: UICollectionViewDataSource, UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return peopleData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PeopleCell", for: indexPath) as? PeopleCell else {
            return UICollectionViewCell()
        }
        
        let person = peopleData[indexPath.item]
        cell.configure(emoji: person.emoji, name: person.name, role: person.role, introduction: person.intro)
        return cell
    }
}
