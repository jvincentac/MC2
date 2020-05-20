//
//  completionViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 19/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class completionViewController: UIViewController {
    
    @IBOutlet weak var largeStar: UIImageView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var smallStarRight: UIImageView!
    @IBOutlet weak var smallStarLeft: UIImageView!
    @IBOutlet weak var leftThumbBackground: UIImageView!
    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var completeFailedLabel: UILabel!
    @IBOutlet weak var xpLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var repeatBtn: UIButton!
    
    var success = UserDefaults.standard.object(forKey: "success") as! Int
    var stage = 1
    var story = 1
    var xp = 0
    var coin = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        configureStar()
    }
    
    func configurePage() {
        contentView.layer.borderWidth = 8
        contentView.layer.cornerRadius = 15
        leftThumbBackground.transform = leftThumbBackground.transform.rotated(by: CGFloat(Double.pi / -10))
        stageLabel.text = "Stage \(stage)"
        
        if success == 0 {
            completeFailedLabel.text = "Failed"
        }
        else {
            completeFailedLabel.text = "Completed"
        }
    }
    
    func configureStar() {
        if success == 0 {
            largeStar.isHidden = true
            smallStarRight.isHidden = true
            smallStarLeft.isHidden = true
            xpLabel.isHidden = true
            coinLabel.isHidden = true
        }
        else if success == 1 {
            largeStar.isHidden = true
            smallStarRight.isHidden = true
            xpLabel.text = "+ 5 xp"
            coinLabel.text = "+ 150 coins"
        }
        else if success == 2 {
            largeStar.isHidden = true
            xpLabel.text = "+ 10 xp"
            coinLabel.text = "+ 250 coins"
        }
        else if success == 3 {
            xpLabel.text = "+ 17 xp"
            coinLabel.text = "+ 500 coins"
            repeatBtn.isHidden = true
            repeatBtn.isEnabled = false
        }
    }
    @IBAction func repeatStage(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Quiz", bundle: nil).instantiateViewController(withIdentifier: "multipleChoice") as! multipleChoiceViewController
        sb.modalPresentationStyle = .fullScreen
        sb.story = story
        sb.stage = stage
        self.present(sb, animated: true, completion: nil)
    }
}
