//
//  MemoData.swift
//  JDaeLeeMemo
//
//  Created by 노주영 on 2022/04/28.
//

import UIKit
import CoreData

class MemoData{
    var title: String?          //리스트에 표시될 타이틀
    var contents: String?       //글 내용
    var regdate: Date?          //작성일자
    var writelength: Int?       //글자 수
    var secret: Bool?           //비밀 여부
    var number: String?         //비밀번호
    
    //MemoMO 객체를 참조하기 위한 속성
    var objectID: NSManagedObjectID?
    
}
