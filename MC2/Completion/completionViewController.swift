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
    @IBOutlet weak var stageLabel: UILabel!
    @IBOutlet weak var completeFailedLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var repeatBtn: UIButton!
    
    var success = UserDefaults.standard.object(forKey: "success") as! Int
    var stage = 0
    var story = 0
    var coin : Int16 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        configureStar()
    }
    
    func configurePage() {
        contentView.layer.borderWidth = 8
        contentView.layer.cornerRadius = 15
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
            coinLabel.isHidden = true
        }
        else if success == 1 {
            largeStar.isHidden = true
            smallStarRight.isHidden = true
            coinLabel.text = "+ 150 coins"
            coin = 150
        }
        else if success == 2 {
            largeStar.isHidden = true
            coinLabel.text = "+ 250 coins"
            coin = 250
        }
        else if success == 3 {
            coinLabel.text = "+ 500 coins"
            coin = 500
            repeatBtn.isHidden = true
            repeatBtn.isEnabled = false
            
            updateStar()
        }
        
        User.updateUserCoin(viewContext: getViewContext(), coin: coin)
    }
    
    func updateStar() {
        if story == 1 {
            var starTotal = UserDefaults.standard.integer(forKey: "story1")
            if stage == 1 {
                starTotal = 3
            }
            else if stage == 2 {
                starTotal = 6
            }
            else if stage == 3 {
                starTotal = 9
            }
            UserDefaults.standard.set(starTotal, forKey: "story1")
        }
        else if story == 2 {
            var starTotal = UserDefaults.standard.integer(forKey: "story2")
            if stage == 1 {
                starTotal = 3
            }
            else if stage == 2 {
                starTotal = 6
            }
            else if stage == 3 {
                starTotal = 9
            }
            UserDefaults.standard.set(starTotal, forKey: "story2")
        }
        else if story == 3 {
            var starTotal = UserDefaults.standard.integer(forKey: "story3")
            if stage == 1 {
                starTotal = 3
            }
            else if stage == 2 {
                starTotal = 6
            }
            else if stage == 3 {
                starTotal = 9
            }
            UserDefaults.standard.set(starTotal, forKey: "story3")
        }
    }
    
    @IBAction func repeatStage(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Quiz", bundle: nil).instantiateViewController(withIdentifier: "multipleChoice") as! multipleChoiceViewController
        sb.modalPresentationStyle = .fullScreen
        sb.story = story
        sb.stage = stage
        self.present(sb, animated: true, completion: nil)
    }
    
    @IBAction func `continue`(_ sender: Any) {
        let sb = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "Discover") as! DiscoverStoriesViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true, completion: nil)
    }
}
