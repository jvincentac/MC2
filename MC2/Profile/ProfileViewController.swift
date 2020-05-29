//
//  ProfileViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 23/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var userAvatarImg: UIImageView!
    @IBOutlet weak var userNickname: UILabel!
    @IBOutlet weak var userCoin: UILabel!
    @IBOutlet weak var middleAvatar: UIImageView!
    @IBOutlet weak var leftAvatar: UIImageView!
    @IBOutlet weak var rightAvatar: UIImageView!
    @IBOutlet weak var price1: UILabel!
    @IBOutlet weak var price2: UILabel!
    @IBOutlet weak var price3: UILabel!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    
    var standardAvatar = UserDefaults.standard.object(forKey: "standardAvatarImg") as! [String]
    var avatar = UserDefaults.standard.object(forKey: "avatarImg") as! [String]
    var allAvatar: [String] = []
    var paidAvatar: [UIImage] = []
    var idx = 1
    var coin = 0
    var n = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        configureUserData()
        configureAvatar()
        nicknameTextField.delegate = self
        
        if let limit = UserDefaults.standard.object(forKey: "limit") {
            n = limit as! Int
        }
    }
  
    func configurePage() {
        contentView.layer.cornerRadius = 10
        price1.isHidden = true
        price2.isHidden = true
        price3.isHidden = true
        successLabel.isHidden = true
        saveBtn.layer.cornerRadius = 5
    }
    
    func configureUserData() {
        UserCoreDataViewController.user = User.fetchAll(viewContext: getViewContext())
        
        userNickname.text = UserCoreDataViewController.user.last!.userName
        userAvatarImg.image = UIImage(named: UserCoreDataViewController.user.last!.avatar!)
        userCoin.text = String(UserCoreDataViewController.user.last!.coin) + " Coins"
        
        nicknameTextField.text = UserCoreDataViewController.user.last!.userName
    }
    
    func configureAvatar() {
        allAvatar = standardAvatar + avatar
        leftAvatar.image = UIImage(named: "\(allAvatar[idx-1]).png")
        middleAvatar.image = UIImage(named: "\(allAvatar[idx]).png")
        rightAvatar.image = UIImage(named: "\(allAvatar[idx+1]).png")
        
        for avatar in avatar {
            paidAvatar.append(UIImage(named: "\(avatar).png")!)
        }
    }
    
    func checkLabel2() {
        if paidAvatar.contains(leftAvatar.image!) {
            price1.isHidden = false
        }
        else {
            price1.isHidden = true
        }
        
        if paidAvatar.contains(middleAvatar.image!) {
            price2.isHidden = false
            coin = -500
        }
        else {
            price2.isHidden = true
            coin = 0
        }
        
        if paidAvatar.contains(rightAvatar.image!) {
            price3.isHidden = false
        }
        else {
            price3.isHidden = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nicknameTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func changeRight(_ sender: Any) {
        idx += 1
        
        if idx == 6 {
            idx = 0
        }
        
        if idx == 0 {
            leftAvatar.image = UIImage(named: "\(allAvatar[5]).png")
            middleAvatar.image = UIImage(named: "\(allAvatar[idx]).png")
            rightAvatar.image = UIImage(named: "\(allAvatar[idx+1]).png")
        }
        else if idx == 5 {
            leftAvatar.image = UIImage(named: "\(allAvatar[idx-1]).png")
            middleAvatar.image = UIImage(named: "\(allAvatar[idx]).png")
            rightAvatar.image = UIImage(named: "\(allAvatar[0]).png")
        }
        else {
            leftAvatar.image = UIImage(named: "\(allAvatar[idx-1]).png")
            middleAvatar.image = UIImage(named: "\(allAvatar[idx]).png")
            rightAvatar.image = UIImage(named: "\(allAvatar[idx+1]).png")
        }
        checkLabel2()
    }
    
    @IBAction func changeLeft(_ sender: Any) {
        idx -= 1
        
        if idx == -1 {
            idx = 5
        }
        
        if idx == 0 {
            leftAvatar.image = UIImage(named: "\(allAvatar[5]).png")
            middleAvatar.image = UIImage(named: "\(allAvatar[idx]).png")
            rightAvatar.image = UIImage(named: "\(allAvatar[idx+1]).png")
        }
        else if idx == 5 {
            leftAvatar.image = UIImage(named: "\(allAvatar[idx-1]).png")
            middleAvatar.image = UIImage(named: "\(allAvatar[idx]).png")
            rightAvatar.image = UIImage(named: "\(allAvatar[0]).png")
        }
        else {
            leftAvatar.image = UIImage(named: "\(allAvatar[idx-1]).png")
            middleAvatar.image = UIImage(named: "\(allAvatar[idx]).png")
            rightAvatar.image = UIImage(named: "\(allAvatar[idx+1]).png")
        }
        checkLabel2()
    }
    
    @IBAction func saveAll(_ sender: Any) {
        if idx > n && UserCoreDataViewController.user.last!.coin >= 500{
            User.updateUserCoin(viewContext: getViewContext(), coin: Int16(coin))
            User.updateUserAvatar(viewContext: getViewContext(), avatar: "\(allAvatar[idx]).png")
            standardAvatar.append("\(allAvatar[idx])")
            UserDefaults.standard.set(standardAvatar, forKey: "standardAvatarImg")
            avatar.remove(at: idx-3)
            UserDefaults.standard.set(avatar, forKey: "avatarImg")
            successLabel.isHidden = false
            successLabel.text = "Save Success"
            n += 1
            UserDefaults.standard.set(n, forKey: "limit")
            price2.isHidden = true
        }
        else if idx > n && UserCoreDataViewController.user.last!.coin < 500{
            successLabel.isHidden = false
            successLabel.text = "Save Failed, Coin Not Enough"
        }
        else if idx <= n {
            User.updateUserName(viewContext: getViewContext(), userName: nicknameTextField.text!)
            User.updateUserAvatar(viewContext: getViewContext(), avatar: "\(allAvatar[idx]).png")
            successLabel.isHidden = false
            successLabel.text = "Save Success"
        }
        
        configureUserData()
    }
    
    @IBAction func backToHome(_ sender: Any) {
        let sb = UIStoryboard(name: "First", bundle: nil).instantiateViewController(withIdentifier: "Discover") as! DiscoverStoriesViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true, completion: nil)
    }
}
