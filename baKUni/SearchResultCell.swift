//
//  SearchResultCell.swift
//  baKUni
//
//  Created by 최승연 on 2020/01/31.
//  Copyright © 2020 최승연. All rights reserved.
//

import UIKit

class SearchResultCell: UITableViewCell {

    let lbSeat = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: "searchResultCell")
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override func prepareForReuse() {
        self.textLabel?.text = nil
        self.detailTextLabel?.text = nil
        lbSeat.text = nil
    }
    
    func setUpView(){
        lbSeat.font = .systemFont(ofSize: 15)
        self.contentView.addSubview(lbSeat)
        lbSeat.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
}
