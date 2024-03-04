//
//  API.swift
//  MyMemoApp
//
//  Created by Shotaro Tanimura on 2024/03/04.
//

import Foundation

struct APIResponse: Codable{
    let code: Int
}

func postMemoData(memoData: String, date: Date) {
    // APIのURL
    let apiUrl = URL(string: "https://api.example.com/data")!
    
    let memoDict: [String: Any] = [
        "memo": memoData,
        "memoDate": date
    ]

    do {
            let jsonData = try JSONSerialization.data(withJSONObject: memoDict, options: [])
            
            // URLSessionを作成
            let session = URLSession.shared
            
            // POSTリクエストを作成
            var request = URLRequest(url: apiUrl)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            // URLSessionDataTaskを作成してリクエストを送信
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                // HTTPレスポンスをチェック
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid HTTP response")
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    // データを取得してAPIResponse型にデコードする
                    if let data = data {
                        do {
                            let decoder = JSONDecoder()
                            let apiResponse = try decoder.decode(APIResponse.self, from: data)
                            
                            // レスポンスを使って何かしらの処理を行う
                            print("API Response Code: \(apiResponse.code)")
                            
                        } catch {
                            print("Error decoding JSON: \(error.localizedDescription)")
                        }
                    }
                } else {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
            }
            
            // タスクを実行
            task.resume()
            
        } catch {
            print("Error serializing JSON: \(error.localizedDescription)")
        }
    }

    // 使用例
    
