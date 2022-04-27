//
//  MemoWriteVC.swift
//  JDaeLeeMemo
//
//  Created by 노주영 on 2022/04/28.
//

import UIKit

class MemoWriteVC: UIViewController {
    var subject: String!        //제목 저장 객체
    
    @IBOutlet var contents: UITextView!
    @IBOutlet var secretSwich: UISwitch!
    @IBOutlet var secretLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: 아웃렛 메소드
    @IBAction func save(_ sender: UIBarButtonItem){
        
    }
    
    @IBAction func changeSwich(_ sender: UISwitch){
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
