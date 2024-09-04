//
//  SearchViewController.swift
//  u_no
//
//  Created by 유민우 on 9/4/24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
//        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.tintColor = .lightGray
        searchBar.searchTextField.textColor = .black
        searchBar.searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchBar.searchTextField.layer.borderWidth = 1.0
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.clipsToBounds = true
        
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray
        ]
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "검색어를 입력하세요", attributes: placeholderAttributes)
        
//        if let glassIconView = searchBar.searchTextField.leftView as? UIImage {
//            glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
//            glassIconView.tintColor = .lightGray
//        }
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
