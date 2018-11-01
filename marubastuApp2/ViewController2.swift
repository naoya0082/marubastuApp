//
//  ViewController2.swift
//  marubastuApp2
//
//  Created by 高橋直也 on 2018/10/30.
//  Copyright © 2018 Takahashi Naoya. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    
    @IBOutlet weak var AddQuestionArea: UITextField!
    let userDefaults = UserDefaults.standard
    
    var answerResult: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let close = UIAlertAction(title: "閉じる", style: .cancel, handler: nil)
        alert.addAction(close)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func GoTop(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func TFSelectButton(_ sender: Any) {
        if (sender as AnyObject).selectedSegmentIndex == 0{
            answerResult = false
            
        }else if (sender as AnyObject).selectedSegmentIndex == 1{
            answerResult = true
            
        }
    }
    
    @IBAction func saveQuestionButton(_ sender: Any) {
        if AddQuestionArea.text == "" {
            showAlert(message: "問題文を作成してください")
            
            return
            
        }else{
            
            showAlert(message: "問題を保存しました")
            
        }
        
        var saveSub:[String:Any] = [:]
        saveSub["question"] = AddQuestionArea.text!
        saveSub["answer"] = answerResult
        
        if var saveQuestion = userDefaults.object(forKey: "Questions") as? [[String: Any]] {
            saveQuestion.append(saveSub)
            userDefaults.set(saveQuestion,forKey: "Questions")
            AddQuestionArea.text = ""
        }else{
            let sendItem:[[String:Any]] = [saveSub]
            userDefaults.set(sendItem,forKey: "Questions")
            AddQuestionArea.text = ""
        }
        
    }
    @IBAction func delQuestionButton(_ sender: Any) {
        userDefaults.removeObject(forKey: "Questions")
        showAlert(message: "問題を削除しました")
        
    }
}
