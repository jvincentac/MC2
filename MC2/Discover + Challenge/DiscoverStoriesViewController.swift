//
//  DiscoverStoriesViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 23/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class DiscoverStoriesViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
    }
    
    func configurePage() {
        contentView.layer.cornerRadius = 8
    }
    
    @IBAction func story1(_ sender: Any) {
        let sb = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "Challenge") as! ChallengeViewController
        sb.modalPresentationStyle = .fullScreen
        sb.story = 1
        self.present(sb, animated: true, completion: nil)
    }
    
    @IBAction func story2(_ sender: Any) {
        let sb = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "Challenge") as! ChallengeViewController
        sb.modalPresentationStyle = .fullScreen
        sb.story = 2
        self.present(sb, animated: true, completion: nil)
    }
    
    @IBAction func story3(_ sender: Any) {
        let sb = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "Challenge") as! ChallengeViewController
        sb.modalPresentationStyle = .fullScreen
        sb.story = 3
        self.present(sb, animated: true, completion: nil)
    }
    
    @IBAction func toProfile(_ sender: Any) {
        let sb = UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "Profile") as! ProfileViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true, completion: nil)
    }
}
