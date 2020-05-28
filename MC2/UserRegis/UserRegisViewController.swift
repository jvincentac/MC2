//
//  UserRegisViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 13/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class UserRegisViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var currAvatar: UIImageView!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var nameText: UITextField!
    
    var avatarImg : [String] = []
    var idx = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        nameText.delegate = self
    }
    
    func configurePage() {
        contentView.layer.cornerRadius = 15
        continueBtn.isHidden = true
        continueBtn.isEnabled = false
        
        avatarImg = UserDefaults.standard.object(forKey: "standardAvatarImg") as! [String]
        
        currAvatar.image = UIImage(named: "\(avatarImg[idx]).png")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameText.resignFirstResponder()
        return true
    }

    @IBAction func changeRight(_ sender: Any) {
        idx += 1
        if idx == 3 {
            idx = 0
        }
        currAvatar.image = UIImage(named: "\(avatarImg[idx]).png")
    }
    @IBAction func changeLeft(_ sender: Any) {
        idx -= 1
        if idx == -1 {
            idx = 2
        }
        currAvatar.image = UIImage(named: "\(avatarImg[idx]).png")
    }
    
    @IBAction func fillName(_ sender: Any) {
        if nameText.text != "" {
            continueBtn.isEnabled = true
            continueBtn.isHidden = false
        }
    }
    @IBAction func continueToMain(_ sender: Any) {
        if let saveUser = User.saveUserData(viewContext: getViewContext(), userName: nameText.text ?? "", avatar: "\(avatarImg[idx]).png", coin: 0) {
            UserCoreDataViewController.user.append(saveUser)
        }
        
        UserDefaults.standard.set(true, forKey: "visited")
        
        let sb = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "Discover") as! DiscoverStoriesViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true, completion: nil)
    }
}
