//
//  CoreDataTestViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 20/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class UserCoreDataViewController: UIViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var exp: UILabel!
    @IBOutlet weak var coin: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var fontTest: UILabel!
    
    static var user: [User] = [] //jgn dihapus
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserCoreDataViewController.user = User.fetchAll(viewContext: getViewContext())
        
        userNameLabel.text = UserCoreDataViewController.user.last!.userName
        userAvatar.image = UIImage(named: UserCoreDataViewController.user.last!.avatar!)
        exp.text = String(UserCoreDataViewController.user.last!.exp)
        coin.text = String(UserCoreDataViewController.user.last!.coin)
        
        fontTest.font = UIFont.systemFont(ofSize: 17, weight: .heavy)
    }
    
//    @IBAction func saveToCoreData(_ sender: UIButton) {
//        let userName = userNameTextField.text
//
//        if let saveUser = User.saveUserData(viewContext: getViewContext(), userName: userName ?? "", avatar: "23-1", exp: 0, coin: 0) {
//            UserCoreDataViewController.user.append(saveUser)
//        }
//    }
//
//    @IBAction func updateCoreData(_ sender: Any) {
//        let userName = userNameTextField.text
//        User.updateUserName(viewContext: getViewContext(), userName: userName ?? "")
//    }
//
//    @IBAction func fetchCoreData(_ sender: Any) {
//        UserCoreDataViewController.user = User.fetchAll(viewContext: getViewContext())
//        userNameLabel.text = UserCoreDataViewController.user.last!.userName
//    }
//
//    @IBAction func deleteCoreData(_ sender: Any) {
//        User.deleteAll(viewContext: getViewContext())
//        UserCoreDataViewController.user.removeAll()
//        print("remove success")
//    }
    
    @IBAction func toMC(_ sender: Any) {
        let sb = UIStoryboard(name: "Quiz", bundle: nil).instantiateViewController(withIdentifier: "multipleChoice") as! multipleChoiceViewController
        sb.modalPresentationStyle = .fullScreen
        self.present(sb, animated: true, completion: nil)
    }
}
