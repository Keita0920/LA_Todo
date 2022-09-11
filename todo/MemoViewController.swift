//
//  MemoViewController.swift
//  todo
//
//  Created by K I on 2022/09/08.
//

import UIKit
import RealmSwift

class MemoViewController: UIViewController ,UITextFieldDelegate{
    
    @IBOutlet var titleTextField:UITextField!
    @IBOutlet var contentTextField:UITextField!
    @IBOutlet weak var dateTextField: UITextField!
    
    let realm=try!Realm()
    var datePicker: UIDatePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate=self
        contentTextField.delegate=self
        dateTextField.delegate=self
        let memo:Memo?=read()
        titleTextField.text=memo?.title
        contentTextField.text=memo?.content
        dateTextField.text=memo?.date
        
        // ピッカー設定
        datePicker.datePickerMode = UIDatePicker.Mode.dateAndTime
        datePicker.timeZone = NSTimeZone.local
        datePicker.locale = Locale.current
        dateTextField.inputView = datePicker
                
        // 決定バーの生成
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 35))
        let spacelItem = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
        toolbar.setItems([spacelItem, doneItem], animated: true)
                
        // インプットビュー設定
        dateTextField.inputView = datePicker
        dateTextField.inputAccessoryView = toolbar
        
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    
    // 決定ボタン押下
        @objc func done() {
            dateTextField.endEditing(true)
            
            // 日付のフォーマット
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            dateTextField.text = "\(formatter.string(from: datePicker.date))"
        }
    
    
    
    func read()->Memo?{
        return realm.objects(Memo.self).first
    }
    
    @IBAction func save(){
        let title:String=titleTextField.text!
        let content:String=contentTextField.text!
        let date:String=dateTextField.text!
        
        let memo:Memo?=read()
        if memo != nil{
            try! realm.write{
                memo!.title=title
                memo!.content=content
                memo!.date=date
                print(ViewController.titleArray.count)
                ViewController.titleArray += [["title":title,"detail":date]]
                print(ViewController.titleArray.count)
                print(ViewController.titleArray)
                
            }
        }else{
            let newMemo=Memo()
            newMemo.title=title
            newMemo.content=content
            newMemo.date=date
            
            try!realm.write{
                realm.add(newMemo)
            }
        }
        let alert:UIAlertController=UIAlertController(title: "成功", message: "保存しました", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil)
        )
        present(alert,animated: true,completion: nil)
    }
    
    func textFieldShouldReturn(_ textField:UITextField)->Bool{
        textField.resignFirstResponder()
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
