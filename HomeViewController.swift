//
//  HomeViewController.swift
//  MyMemoApp
//
//  Created by Shotaro Tanimura on 2024/02/20.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var memoDataList: [MemoDataModel] = []
    
    override func viewDidLoad() {
        // このクラスが表示される際に呼び出されるメソッド
        // 親クラスのメソッドを子供クラスで定義し直す
        //画面の表示非表示に呼び出されるメソッドをライフサイクルメソッド
        tableView.dataSource = self //self はhomeviewcontorollerクラス
        tableView.delegate = self
        tableView.tableFooterView = UIView() //空のUIviewクラスを表示
        setMemoData()
        setNavigationBarButton()
    }
    
    func setMemoData() {
        for i in 1...5 {
            let memoDataModel = MemoDataModel(test: "このメモは\(i)番目のメモです", recordDate: Date())
            memoDataList.append(memoDataModel)
        }
    }
    @objc func tapAddButton(){
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        let memoDetailViewController = storyboard.instantiateViewController(identifier: "MemoDetailViewController") as! MemoDetailViewController
        navigationController?.pushViewController(memoDetailViewController, animated: true)
    }
    func setNavigationBarButton(){
        let buttonActionSelector: Selector = #selector(tapAddButton)
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: buttonActionSelector)
        navigationItem.rightBarButtonItem = rightBarButton
    }
}
//extensionを使用してhomeviewcontorollerクラスの外部にデータソース関連のメソッドを独立させている
extension HomeViewController: UITableViewDataSource {
    //UI table viewに表示するリストの数を指定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoDataList.count
    }
    // リストの中身を表示　リストの一つ一つをセルと呼ぶ
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        //reuseIdentifierパラメータには文字列"cell"が渡されています。これがセルの識別子です。
        let memoDataModel : MemoDataModel = memoDataList[indexPath.row]
        cell.textLabel?.text = memoDataModel.test
        cell.detailTextLabel?.text = "\(memoDataModel.recordDate)"
        return cell
    }
}

//セルがタップされたときに画面遷移する処理
extension HomeViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)// コード上でストーリーボードを使えるようにする
        let memoDetailViewController = storyboard.instantiateViewController(identifier: "MemoDetailViewController") as! MemoDetailViewController //ストーリーボードからMemoDetailViewControllerというStoryboard IDを持つビューコントローラーのインスタンスを取得
        let memoData = memoDataList[indexPath.row]
        memoDetailViewController.configure(memo: memoData)
        tableView.deselectRow(at: indexPath, animated: true) //選択セレクト状態の解除
        navigationController?.pushViewController(memoDetailViewController, animated: true)//画面遷移処理を定義
    }
}
