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
    
    lazy var dao = MemoDAO()
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var secretSwich: UISwitch!
    @IBOutlet weak var secretLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var barButton: UIBarButtonItem!
    
    var subject: String!                 //제목 저장 객체
    var writeLength: String!             //글자 수
    var secretState: Bool! = false       //비밀메모 상태
    var secretnumber: String! = ""      //비밀번호
    
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
    @IBAction func changeSwich(_ sender: UISwitch){
        if self.secretSwich.isOn == true {
            let alert = UIAlertController(title: "비밀번호를 입력해주세요.", message: nil, preferredStyle: .alert)
            
            alert.addTextField(){ (tf) in
                tf.placeholder = "비밀번호"
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ (_) in
                self.secretSwich.isOn = false
                self.secretState = false
                self.secretnumber = ""
            })
            
            alert.addAction(UIAlertAction(title: "OK", style: .default){ (_) in
                //비밀 번호를 입력하지 않았을 경우
                if alert.textFields?[0].text == ""{
                    let alert1 = UIAlertController(title: nil, message: "초기 비밀번호를 입력해주세요.", preferredStyle: .alert)
                    
                    alert1.addAction(UIAlertAction(title: "OK", style: .cancel){ (_) in
                        self.secretSwich.isOn = false
                    })
                    
                    self.present(alert1, animated: false)
                } else {
                //레이블 변경
                    let secretText = alert.textFields?[0].text
                    self.secretLabel.text = "Secret Activation \n" + "비밀번호: \(secretText!)"
                    self.secretLabel.textColor = UIColor.blue
                
                    self.secretnumber = secretText
                    self.secretState = true
                }
            })
            self.present(alert, animated: false)
        } else {
            //레이블 변경
            self.secretLabel.text = "Secret Deactivation"
            self.secretLabel.textColor = UIColor.red
            
            //저장할 변수
            self.secretnumber = ""
            self.secretState = false
        }
    }
    
    
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
        
            if self.contents.text != self.param?.contents {
                self.dao.editText(objectID: (self.param?.objectID)!, title: (self.subject)!, contents: (self.contents.text)!, writelength: (self.writeLength)!)
            }
            
            if self.secretnumber != self.param?.number{
                self.dao.editSecretNumber(objectID: (self.param?.objectID)!, secret: (self.secretState)!, number: self.secretnumber)
            }
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
    
    //사용자가 텍스트 뷰에 입력 시 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        //내용을 최대 10자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        self.writeLength = String(describing: contents.length)
        let length = contents.length > 28 ? 28 : contents.length
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.numberLabel.text = "Number of characters : \(String(describing: contents.length))"
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        self.view.endEditing(true)
        return true
    }
    
}
