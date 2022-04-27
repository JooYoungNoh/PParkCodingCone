//
//  MemoDAO.swift
//  JDaeLeeMemo
//
//  Created by 노주영 on 2022/04/28.
//

import UIKit
import CoreData

class MemoDAO{
    //관리 객체 컨텍스트를 반환하는 멤버 변수 추가
    lazy var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }()
    
    //MARK: 메소드들
    //저장된 메모 전체를 불러오는 메소드
    func fetch(keyword text: String? = nil) -> [MemoData]{
        var memolist = [MemoData]()
        
        //요청 객체 생성
        let fetchRequest: NSFetchRequest<MemoMO> = MemoMO.fetchRequest()
        
        //최신 글 순으로 정렬하도록 정렬 객체 생성
        let regdateDesc = NSSortDescriptor(key: "regdate", ascending: false)
        fetchRequest.sortDescriptors = [regdateDesc]
        
        //검색 키워드가 있을 경우 검색 조건 추가
        if let t = text, t.isEmpty == false{
            fetchRequest.predicate = NSPredicate(format: "contents CONTAINS[c] %@", t)
        }
        
        do{
            let resultset = try self.context.fetch(fetchRequest)
            
            //읽어온 결과 집합을 순회하면서 [MemoData] 타입으로 반환
            for record in resultset{
                //MemoData 객체 생성
                let data = MemoData()
                
                //MemoMo 프로퍼티 값을 MemoData의 프로퍼티로 복사
                data.title = record.title
                data.contents = record.contents
                data.regdate = record.regdate! as Date
                data.writelength = record.writelength as! Int
                data.secret = record.secret
                data.number = record.number
                data.objectID = record.objectID
                
                //MemoData 객체를 memolist 배열에 추가
                memolist.append(data)
                }
            } catch let e as NSError{
                NSLog("AN error has occurred : %s", e.localizedDescription)
            }
        return memolist
    }
    
    //새 메모를 저장하는 메소드
    func insert(_ data: MemoData){
        //관리 객체 인스턴스 생성
        let object = NSEntityDescription.insertNewObject(forEntityName: "Memo", into: self.context) as! MemoMO
        
        //MemoData로 부터 값을 복사
        object.title = data.title
        object.contents = data.contents
        object.regdate = data.regdate!
        object.writelength = Int64(data.writelength!)
        object.secret = data.secret!
        object.number = data.number
        
        //영구 저장소에 변경 사항을 반영
        do{
            try self.context.save()
        } catch let error as NSError {
            NSLog("An error has occurred : %s", error.localizedDescription)
        }
    }
    
    //메모 내용을 삭제하기 위한 메소드
    func delete(_ objectId: NSManagedObjectID) -> Bool {
        //삭제할 객체를 찾아, 컨텍스트에서 삭제
        let object = self.context.object(with: objectId)
        self.context.delete(object)
        
        do{
            try self.context.save()
            return true
        } catch let error as NSError {
            NSLog("An error has occurred : %s", error.localizedDescription)
            return false
        }
    }
}

