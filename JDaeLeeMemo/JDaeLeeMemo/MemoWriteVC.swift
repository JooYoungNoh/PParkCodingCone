//
//  MemoWriteVC.swift
//  JDaeLeeMemo
//
//  Created by 노주영 on 2022/04/28.
//

import UIKit

class MemoWriteVC: UIViewController, UITextViewDelegate {
    var subject: String!        //제목 저장 객체
    
    @IBOutlet var contents: UITextView!
    @IBOutlet var secretSwich: UISwitch!
    @IBOutlet var secretLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contents.delegate = self
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
        
        let data = MemoData()
        
        data.title = self.subject
        data.contents = self.contents.text
        data.regdate = Date()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memolist.append(data)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeSwich(_ sender: UISwitch){
        
    }
    
    //MARK: 텍스트 뷰 메소드
    //사용자가 텍스트 뷰에 입력 시 호출되는 메소드
    func textViewDidChange(_ textView: UITextView) {
        //내용을 최대 10자리까지 읽어 subject 변수에 저장
        let contents = textView.text as NSString
        let length = contents.length > 10 ? 10 : contents.length
        self.subject = contents.substring(with: NSRange(location: 0, length: length))
        
        
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
