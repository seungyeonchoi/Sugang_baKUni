
//
//  File.swift
//  baKUni
//
//  Created by 최승연 on 2020/02/02.
//  Copyright © 2020 최승연. All rights reserved.
//

import Foundation
class Subject {
    var grade:String = ""   // 1: 학년
    var code:String = ""// 2: 학수번호
    var completion: String = ""// 3: 이수구분(ex. 지교 ,전선)
    var id:String = ""// 4: 과목번호
    var name:String = ""               // 5: 과목명
    var point:String = ""               // 6: 학점
    var time:String = ""// 7: 시간
    var major:String = ""           //8:수강학과
    var location:String = ""          //9: 강의교시/강의실
    var professor:String = ""          //10:담당교수
    var isEnglish: String = "" //11: 원어강의
    var way:String = ""//14: 강의종류(e-러닝 /mooc / 일반
    var domain:String = "" //15: 심교 영역(글로벌 ~~)
    var isPass:String = "" //16: 패스교과 여부
    var remarks:String = "" //17: 비고
    var restSeat:String = "" //남은 좌석
    var allSeat:String = "" //남은 좌석
    init(grade: String, code: String, completion:String, id:String, name:String, point:String, time:String, major:String, location:String, professor:String,isEnglish:String, way:String,domain:String,isPass:String,remarks:String) {
        self.grade = grade
        self.code = code
        self.completion = completion
        self.id = id
        self.name = name
        self.point = point
        self.time = time
        self.major = major
        self.location = location
        self.professor = professor
        self.isEnglish = isEnglish
        self.way = way
        self.domain = domain
        self.isPass = isPass
        self.remarks = remarks
    }
    func setInfo(item: [String]) {
        self.grade = item[0]
        self.code = item[1]
        self.completion = item[2]
        self.id = item[3]
        self.name = item[4]
        self.point = item[5]
        self.time = item[6]
        self.major = item[7]
        self.location = item[8]
        self.professor = item[9]
        self.isEnglish = item[10]
        self.way = item[13]
        self.domain = item[14]
        self.isPass = item[15]
        self.remarks = item[16]
    }

    init() {
        
    }
}
