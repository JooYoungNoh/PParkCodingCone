//
//  MemoListVC.swift
//  JDaeLeeMemo
//
//  Created by 노주영 on 2022/04/28.
//

import UIKit

class MemoListVC: UITableViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        self.tableView.allowsSelectionDuringEditing = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDelegate.memolist.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //행에 맞는 데이터 가져오기
        let row = self.appDelegate.memolist[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "memoCell", for: indexPath) as! MemoCell
        
        //타이틀 레이블
        if row.secret == true {
            cell.titleLabel?.text = "🔐 비밀메모입니다."
        } else {
            cell.titleLabel?.text = row.title
        }
        
        //날짜 레이블
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        cell.dateLabel?.text = formatter.string(from: row.regdate!)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = self.appDelegate.memolist[indexPath.row]
        
        if row.secret == true{
            let alert = UIAlertController(title: "비밀번호를 입력하세요", message: nil, preferredStyle: .alert)
            
            alert.addTextField(){ (tf) in
                tf.placeholder = "비밀번호"
            }
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            alert.addAction(UIAlertAction(title: "OK", style: .default){ (_) in
                if alert.textFields?[0].text == row.number {
                    guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoReadVC") as? MemoReadVC else { return }
                
                    vc.param = row
                    self.navigationController?.pushViewController(vc, animated: true)
                } else {
                    let alert2 = UIAlertController(title: nil, message: "비밀번호가 다릅니다.", preferredStyle: .alert)
                    
                    alert2.addAction(UIAlertAction(title: "OK", style: .cancel))
                    
                    self.present(alert2, animated: false)
                }
            })
            
            self.present(alert, animated: false)
        } else {
            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MemoReadVC") as? MemoReadVC else { return }
        
            vc.param = row
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.appDelegate.memolist.remove(at: indexPath.row)
        self.tableView.deleteRows(at: [indexPath], with: .fade)
    }
}
