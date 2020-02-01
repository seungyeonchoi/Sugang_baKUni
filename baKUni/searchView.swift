//
//  searchView.swift
//  baKUni
//
//  Created by 최승연 on 2020/01/31.
//  Copyright © 2020 최승연. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class searchView : UIView {
    let svMain = UIStackView()
    let searchBarContainerView = SearchBarContainerView(customSearchBar: UISearchBar())
    let tvResult = UITableView()
    
    init() {
        super.init(frame: CGRect.zero)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpView(){
        self.addSubview(svMain)
        svMain.axis = .vertical
        svMain.snp.makeConstraints { (make) in
            make.leading.bottom.top.trailing.equalToSuperview()
        }
        
        svMain.addArrangedSubview(searchBarContainerView)
        searchBarContainerView.snp.makeConstraints { (make) in
            make.height.equalTo(100)
        }
        
        tvResult.register(SearchResultCell.self, forCellReuseIdentifier: "searchResultCell")
        tvResult.tableFooterView = UIView()
        tvResult.cellLayoutMarginsFollowReadableWidth = false
        tvResult.separatorInset.left = 0

        svMain.addArrangedSubview(tvResult)
        tvResult.snp.makeConstraints { (make) in
            make.height.greaterThanOrEqualTo(200)
        }
    }
}
