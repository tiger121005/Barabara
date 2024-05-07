//
//  GameViewController.swift
//  Barabara
//
//  Created by TAIGA ITO on 2024/04/24.
//

import UIKit

class GameViewController: UIViewController {
    
    //上の画像
    @IBOutlet var imageView1: UIImageView!
    //真ん中の画像
    @IBOutlet var imageView2: UIImageView!
    //下の画像
    @IBOutlet var imageView3: UIImageView!
    
    //スコアを表示する
    @IBOutlet var resultLabel: UILabel!
    
    //画像を動かすタイマー
    var timer: Timer!
    //スコアの値
    var score: Int = 1000
    //スコアを保存する変数
    var saveData: UserDefaults = UserDefaults.standard
    
    //画面サイズを取得
    let width: CGFloat = UIScreen.main.bounds.width
    //画像の位置の配列
    var positionX: [CGFloat] = [0.0, 0.0, 0.0]
    //画像を動かす幅の配列
    var dx: [CGFloat] = [1.0, 0.5, -1.0]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画像の位置を画面幅の中心に設定
        positionX = [width/2, width/2, width/2]
        //startメソッドを呼び出す
        self.start()
    }
    

    func start() {
        //結果ラベルを非表示にする
        resultLabel.isHidden = true
        
        //タイマーを動かす
        timer = Timer.scheduledTimer(timeInterval: 0.005, target: self, selector: #selector(self.up), userInfo: nil, repeats: true)
    }
    
    @objc func up() {
        for i in 0..<3 {
            //端に来たら動かす方向を逆にする
            if positionX[i] > width || positionX[i] < 0 {
                dx[i] = dx[i] * -1
            }
            //画像の位置をdx分ずらす
            positionX[i] += dx[i]
            
        }
        
        //画像をずらした位置に移動させる
        imageView1.center.x = positionX[0]
        imageView2.center.x = positionX[1]
        imageView3.center.x = positionX[2]
    }
    
    @IBAction func stop() {
        //もしタイマーが動いていたら
        if timer.isValid == true {
            //タイマーを止めるよ
            timer.invalidate()
        }
        
        for i in 0..<3 {
            //スコアを計算する
            score = score - abs(Int(width/2 - positionX[i])) * 2
        }
        //結果ラベルにスコアを表示する
        resultLabel.text = "スコア:" + String(score)
        //結果ラベルを表示する
        resultLabel.isHidden = false
        
        let highScore1: Int = saveData.integer(forKey: "score1")
        let highScore2: Int = saveData.integer(forKey: "score2")
        let highScore3: Int = saveData.integer(forKey: "score3")
        
        if score > highScore1 {
            saveData.set(score, forKey: "score1")
            saveData.set(highScore1, forKey: "score2")
            saveData.set(highScore2, forKey: "score3")
        } else if score > highScore2 {
            saveData.set(score, forKey: "score2")
            saveData.set(highScore2, forKey: "score3")
        } else if score > highScore3 {
            saveData.set(score, forKey: "score3")
        }
    }
    
    @IBAction func retry() {
        //スコアを1000に戻す
        score = 1000
        //画像の位置を真ん中に戻す
        positionX = [width/2, width/2, width/2]
        
        if timer.isValid == false {
            //スタートメソッドを呼び出す
            self.start()
        }
    }
    
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
    }

}
