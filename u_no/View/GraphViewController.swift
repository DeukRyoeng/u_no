//
//  GraphViewController.swift
//  u_no
//
//  Created by 백시훈 on 8/29/24.
//

import Foundation
import UIKit
import DGCharts
class GraphViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    private let graphView = GraphView()
    private let testData: [String] = ["2024-02-01", "2024-02-02", "2024-02-03", "2024-02-04", "2024-02-05"]
    private let priceData: [Double] = [18900, 12300, 8900, 23700, 35000]
    private let tableData: [[String]] = [
        ["날짜", "가격", "등락률"],
        ["작년", "54,234", "-4.5"],
        ["2024.08.30", "51,816", "0"],
        ["Data10", "Data11", "Data12"]
    ]
    
    override func loadView() {
        view = graphView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        graphView.collectionView.dataSource = self // 변경: 데이터 소스 설정
        graphView.collectionView.delegate = self // 변경: 델리게이트 설정
        setChartData()
    }
    private func setChartData() {
        let entries = generateDataEntries()
        graphView.setData(entries: entries)
    }
    private func dateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
    private func generateDataEntries() -> [ChartDataEntry] {
        
        var entries: [ChartDataEntry] = []
        let formatter = dateFormatter()
        for (index, value) in priceData.enumerated() {
            let date = formatter.date(from: testData[index]) ?? Date()
            let timestamp = date.timeIntervalSince1970
            let entry = ChartDataEntry(x: timestamp, y: value)
            entries.append(entry)
        }

        return entries
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tableData[section].count // 각 섹션의 셀 개수
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return tableData.count // 섹션 개수
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .lightGray

        // 셀에 데이터 설정
        let data = tableData[indexPath.section][indexPath.item]
        let label = UILabel()
        label.text = data
        label.textAlignment = .center
        label.frame = cell.contentView.bounds
        cell.contentView.addSubview(label)
        
        let separator = UIView(frame: CGRect(x: 0, y: cell.contentView.bounds.height - 1, width: cell.contentView.bounds.width, height: 1))
        separator.backgroundColor = .black
        cell.contentView.addSubview(separator)
        
        
        return cell
    }
    
    //UICollectionViewDelegateFlowLayout

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width
        let numberOfColumns: CGFloat = 3 // 3 열
        let itemWidth = totalWidth / numberOfColumns
        return CGSize(width: itemWidth, height: 40) // 셀 크기 설정
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // 셀 간의 간격
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // 줄 간의 간격
    }
}