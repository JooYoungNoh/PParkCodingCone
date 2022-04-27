//
//  MemoReadVC.swift
//  JDaeLeeMemo
//
//  Created by 노주영 on 2022/04/28.
//

import UIKit

class MemoReadVC: UIViewController {
    //메모 데이터를 저장한 변수
    var param: MemoData?
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var secretSwich: UISwitch!
    @IBOutlet weak var secretLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //내용
        self.contents.text = param?.contents
        
        //문장 수
        self.numberLabel.text = "Number of characters : \(String(describing: param?.writelength))"
        
        //에디트 액션 버튼으로 가야됨
        //비밀 여부
        if param?.secret == true {
            self.secretSwich.isOn = true
            self.secretLabel.text = "Secret Activation \n" + "비밀번호: \(param?.number)"
            self.secretLabel.textColor = UIColor.blue
        
        } else {
            self.secretSwich.isOn = false
            self.secretLabel.text = "Secret Deactivation"
            self.secretLabel.textColor = UIColor.red
        }
        
    }
    
}
