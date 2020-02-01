//
//  SearchBarContainerView.swift
//  baKuni
//
//  Created by 최승연 on 08/01/2020.
//  Copyright © 2020 최승연. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftSoup

protocol SearchTextDelegate {
    func searchBarCancelButtonClicked()
    func didSearchTextDone(_ item:Subject)
}

class SearchBarContainerView: UIView, UITextFieldDelegate,UISearchBarDelegate {
    let searchBar: UISearchBar
    var searchDelegate : SearchTextDelegate?
    var sItems = Array<Array<String>>()
    var subject = Subject()
    
    let dispatchGroup = DispatchGroup()
    let dispatchQueue = DispatchQueue(label: "taskQueue")
    let dispatchSemaphore = DispatchSemaphore(value: 0)
    var isSeatLoaded = false
    var isInfoLoaded = false
    
    init(customSearchBar: UISearchBar) {
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)
        addSubview(searchBar)
    }
    
    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        self.frame = frame
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
        searchBar.placeholder = "과목번호를 입력하세요!"
        searchBar.showsSearchResultsButton = true
        searchBar.showsCancelButton = true
        searchBar.returnKeyType = .search
        searchBar.enablesReturnKeyAutomatically = true //글자 쳐야먄 search키 활성화 됨
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        searchBar.searchTextField.delegate = self
        searchBar.delegate = self
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        isSeatLoaded = false
        isInfoLoaded = false
        textField.resignFirstResponder()
        if textField.hasText{
            let text = textField.text!
            searchSeat(keyword: text){
                self.isSeatLoaded = true
                self.doSearchDelegate()
            }
            searchInfo(keyword: text) {
                self.isInfoLoaded = true
                self.doSearchDelegate()
            }
        }
                
        return true
    }
    func doSearchDelegate(){
        if isInfoLoaded && isSeatLoaded{
            searchDelegate?.didSearchTextDone(subject)
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchDelegate?.searchBarCancelButtonClicked()
    }
    
    func searchSeat(keyword:String, completion:(@escaping()->Void)){
        let urlStr = "https://kupis.konkuk.ac.kr/sugang/acd/cour/aply/CourInwonInqTime.jsp?ltYy=2020&ltShtm=B01011&sbjtId="+keyword
        guard let url = URL(string: urlStr) else {return}
        let req = AF.request(url)
        print(url.absoluteString)
        
        req.responseString { (response) in
            let html = response.value
            print(html)
            self.htmlParse(type: "seat",html: html!)
            completion()
        }
        
    }
    func searchInfo(keyword:String, completion:(@escaping()->Void)){
        // dispatchGroup.enter()
        //잘못 검색한거 처리해야함!!
        guard let url = URL(string: "https://kupis.konkuk.ac.kr/sugang/acd/cour/time/SeoulTimetableInfo.jsp") else {return}
        let parameters: [String: String] = ["ltYy": "2020", "ltShtm":"B01011","openSust":"","pobtDiv":"","cultCorsFld":"","sbjtId":keyword,"sbjtNm":""]
        let req = AF.request(url, method: .post, parameters: parameters, encoding:URLEncoding.queryString, headers: ["Content-Type":"application/x-www-form-urlencoded", "Accept":"text/html","Accept-Encoding": "gzip, deflate, br"])
        req.responseString { (response) in
            let html = response.value
            self.htmlParse(type: "info",html: html!)
            completion()
        }
    }
    func htmlParse(type:String,html:String){
        switch type {
        case "seat":
            do {
                let doc: Document = try SwiftSoup.parse(html)
                let srcs = try doc.select("[CLASS=table_bg_white]").array()
                subject.restSeat = try srcs[1].text()
                subject.allSeat = try srcs[2].text()
            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("error")
                
            }
        case "info":
            do {
                let doc: Document = try SwiftSoup.parse(html)
                let srcs = try doc.select("[CLASS=table_bg_white] > td").array()
                var item : [String] = []
                for i in 1..<srcs.count {
                    item.append(try srcs[i].text())
                }
                subject.setInfo(item: item)
                
            } catch Exception.Error(_, let message) {
                print(message)
            } catch {
                print("error")
                
            }
        default:
            break
        }
        
    }
}
