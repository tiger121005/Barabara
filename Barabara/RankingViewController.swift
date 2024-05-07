//
//  RankingViewController.swift
//  Barabara
//
//  Created by TAIGA ITO on 2024/04/24.
//

import UIKit

class RankingViewController: UIViewController {
    
    //ランキング表示用ラベル
    @IBOutlet var rankingLabel1: UILabel!
    @IBOutlet var rankingLabel2: UILabel!
    @IBOutlet var rankingLabel3: UILabel!
    
    //スコアを保存するための変数
    let saveData: UserDefaults = UserDefaults.standard

    override func viewDidLoad() {
        super.viewDidLoad()

        rankingLabel1.text = String(saveData.integer(forKey: "score1"))
        rankingLabel2.text = String(saveData.integer(forKey: "score2"))
        rankingLabel3.text = String(saveData.integer(forKey: "score3"))
    }
    
    @IBAction func toTop() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
