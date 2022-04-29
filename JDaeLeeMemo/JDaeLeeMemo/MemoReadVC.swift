//
//  MemoReadVC.swift
//  JDaeLeeMemo
//
//  Created by 노주영 on 2022/04/28.
//

import UIKit

class MemoReadVC: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {
    //메모 데이터를 저장한 변수
    var param: MemoData?
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var secretSwich: UISwitch!
    @IBOutlet weak var secretLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        
        //내용
        self.contents.text = param?.contents
        
        //문장 수
        self.numberLabel.text = "Number of characters : \((param?.writelength)!)"
        
        //비밀 여부
        if param?.secret == true {
            self.secretSwich.isOn = true
            self.secretLabel.text = "Secret Activation \n" + "비밀번호: \((param?.number)!)"
            self.secretLabel.textColor = UIColor.blue
        
        } else {
            self.secretSwich.isOn = false
            self.secretLabel.text = "Secret Deactivation"
            self.secretLabel.textColor = UIColor.red
        }
        
    }
    
    //MARK: 아웃렛 메소드
    @IBAction func writeEdit(_ sender: UIBarButtonItem){
        if self.barButton.title == "편집" {
            self.barButton.title = "수정"
            self.secretLabel.isHidden = false
            self.numberLabel.isHidden = false
            self.secretSwich.isHidden = false
        } else {
            
            
            self.barButton.title = "편집"
            self.secretLabel.isHidden = true
            self.numberLabel.isHidden = true
            self.secretSwich.isHidden = true
        }
    }
    
    //MARK: 델리게이트 메소드
    //텍스트 뷰
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.barButton.title = "수정"
        self.secretLabel.isHidden = false
        self.numberLabel.isHidden = false
        self.secretSwich.isHidden = false
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
