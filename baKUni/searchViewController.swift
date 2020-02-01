//
//  ViewController.swift
//  baKUni
//
//  Created by 최승연 on 2020/01/31.
//  Copyright © 2020 최승연. All rights reserved.
//

import UIKit

class searchViewController: UIViewController {
    var items=[["2:00 am","교육청 1번"],["3:00 am","교육청 3번"],["4:00 am","Live 신청 - 교육청 4번Live 신청 - 교육청 4번Live 신청 - 교육청 4번Live 신청 - 교육청 4번"],["5:00 am","교육청 5번"],["6:00 am","교육청 6번"],["7:00 am","교육청 7번"],["8:00 am","사설 8번"],["9:00 am","사설 9번"]]
    var sItems : [[String]] = [["temp","temp"]]
    var subject : Subject! = nil
    lazy var mainView: searchView = {
        let view = searchView()
        view.searchBarContainerView.searchDelegate = self
        view.tvResult.delegate = self
        view.tvResult.dataSource = self
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(mainView)
        
        mainView.snp.makeConstraints { (make) in
            make.leading.top.trailing.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }
        // Do any additional setup after loading the view.
    }
    
    
}

extension searchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (subject != nil){
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultCell", for: indexPath) as! SearchResultCell
        cell.textLabel?.text = subject.name
        cell.detailTextLabel?.text = subject.code
        cell.lbSeat.text = subject.allSeat
       // cell.backgroundColor = .red
        return cell
    }
    
    
}

extension searchViewController: UISearchBarDelegate, SearchTextDelegate{
    func searchBarCancelButtonClicked() {
        sItems.removeAll()
        mainView.tvResult.reloadData()
    }
    
    func didSearchTextDone(_ item : Subject) {
        subject = item
        mainView.tvResult.reloadData()
    }
   
    
}
