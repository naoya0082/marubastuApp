//
//  ViewController.swift
//  marubastuApp2
//
//  Created by 高橋直也 on 2018/10/30.
//  Copyright © 2018 Takahashi Naoya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var QuestionLabel: UILabel!
    
    let userDefaults = UserDefaults.standard
    // 表示中の問題番号を格納
    var questionNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 関数を呼び出す
        showQuestion()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let reView = userDefaults.object(forKey: "Questions") as? [[String: Any]]
        
        showQuestion()
    }
    // 問題を表示する関数
    func showQuestion() {
        let questionLabel = userDefaults.object(forKey: "Questions") as? [[String: Any]]
        
        guard var inputQuestion = questionLabel?[questionNum]
            else {
                QuestionLabel.text = "問題を作成する"
                
                return
        }
        
        if inputQuestion != nil {
            QuestionLabel.text = inputQuestion["question"] as? String
        }
    }
    
    func checkAnswer(yourAnswer: Bool) {
        let questionLabel = userDefaults.object(forKey: "Questions") as? [[String: Any]]
        
        guard let question = questionLabel?[questionNum] else {
            return
        }
        
        if let ans = question["answer"] as? Bool {
            
            if yourAnswer == ans {
                //正解
                //currentQuestionNumを+1して次の問題に進む
                questionNum += 1
                
                showAlert(message: "正解！")
            }else{
                // 不正解
                
                showAlert(message: "不正解")
            }
            
        }else{
            print("答えが入っていません")
            return
        }
        
        if (questionLabel?.count)! <= questionNum{
            questionNum = 0
            
        }
        // 問題を表示
        // 正解であれば次の問題を、不正解なら同じ問題を表示
        showQuestion()
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func yesButton(_ sender: Any) {
        checkAnswer(yourAnswer: true)
    }
    
    @IBAction func noButton(_ sender: Any) {
        checkAnswer(yourAnswer: false)
    }
    
    @IBAction func createButton(_ sender: Any) {
        questionNum = 0
    }
}

