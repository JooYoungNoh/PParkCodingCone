//
//  MemoWriteVC.swift
//  JDaeLeeMemo
//
//  Created by 노주영 on 2022/04/28.
//

import UIKit

class MemoWriteVC: UIViewController, UITextViewDelegate {
    var subject: String!              //제목 저장 객체
    var writeLength: Int!             //글자 수
    var secretState: Bool! = false    //비밀메모 상태
    var number: String! = nil         //비밀번호
    
    @IBOutlet weak var contents: UITextView!
    @IBOutlet weak var secretSwich: UISwitch!
    @IBOutlet weak var secretLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
        self.secretLabel.text = "Secret Deactivation"
        self.secretLabel.textColor = UIColor.red
        self.secretSwich.isOn = false
    }
    
    //MARK: 아웃렛 메소드
    @IBAction func save(_ sender: UIBarButtonItem){
        guard self.contents.text?.isEmpty == false else {
            let alert = UIAlertController(title: nil, message: "내용이 입력되지 않았습니다.", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel)
            
            alert.addAction(okAction)
            self.present(alert, animated: false)
            
            return
        }
        //저장할 것
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.regdate = Date()
        data.writelength = self.writeLength
        data.secret = self.secretState
        data.number = self.number
        
        //배열에 추가
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeSwich(_ sender: UISwitch){
        if self.secretSwich.isOn == true {
            let alert = UIAlertController(title: "비밀번호를 입력해주세요.", message: nil, preferredStyle: .alert)
            
            alert.addTextField(){ (tf) in
                tf.placeholder = "비밀번호"
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ (_) in
                self.secretSwich.isOn = false
                self.secretState = false
                self.number = nil
            })
            
            alert.addAction(UIAlertAction(title: "OK", style: .default){ (_) in
                //레이블 변경
                let secretText = alert.textFields?[0].text
                self.secretLabel.text = "Secret Activation \n" + "비밀번호: \(secretText!)"
                self.secretLabel.textColor = UIColor.blue
                
                self.number = secretText
                self.secretState = true
            })
            self.present(alert, animated: false)
        } else {
            //레이블 변경
            self.secretLabel.text = "Secret Deactivation"
            self.secretLabel.textColor = UIColor.red
            
            //저장할 변수
            self.number = nil
            self.secretState = false
        }
    }
    
    //MARK: 텍스트 뷰 메소드
    //사용자가 텍스트 뷰에 입력 시 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        //내용을 최대 10자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        self.writeLength = contents.length
        let length = contents.length > 28 ? 28 : contents.length
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        self.numberLabel.text = "Number of characters : \(String(describing: contents.length))"
        
        
    }

}
