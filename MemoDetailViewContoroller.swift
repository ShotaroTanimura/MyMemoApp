//
//  memoDetailViewContoroller.swift
//  MyMemoApp
//
//  Created by Shotaro Tanimura on 2024/02/25.
//

import UIKit

class MemoDetailViewController : UIViewController{
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        displayData()
        setDoneButton()
    }
    var text:String = ""
    var recordData: Date = Date()
    var dateFormat: DateFormatter{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        return dateFormatter
    }
    func configure(memo: MemoDataModel){
        text = memo.test
        recordData = memo.recordDate
        print(text, recordData)
    }
    func displayData(){
        textView.text = text
        //header titleにタイトルとして指定できる方法
        navigationItem.title = dateFormat.string(from: recordData)
    }
    @objc func tapDoneButton(){
        view.endEditing(true)
    }
    
//    func setDoneButton(){
//        let toolBar = UIToolbar(frame:CGRect(x: 0, y: 0, width: 320, height: 40))
//        let commitButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tapDoneButton))
//        toolBar.items = [commitButton]
//        textView.inputAccessoryView = toolBar
//    }
    func setDoneButton(){
        let toolBar = UIToolbar(frame:CGRect(x: 0, y: 0, width: 320, height: 40))
        let doneButton = UIBarButtonItem(title: "閉じる", style: .plain, target: self, action: #selector(tapDoneButton))
        toolBar.items = [doneButton]
        textView.inputAccessoryView = toolBar
    }

}
