//
//  ViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 10/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let visited = UserDefaults.standard.object(forKey: "visited") {
            let sb = UIStoryboard(name: "Quiz", bundle: nil).instantiateViewController(withIdentifier: "multipleChoice") as! multipleChoiceViewController
            sb.modalPresentationStyle = .fullScreen
            present(sb, animated: true, completion: nil)
        }
        else {
            let sb = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "PVC") as! pageViewController
            sb.modalPresentationStyle = .fullScreen
            present(sb, animated: true, completion: nil)
        }
    }
}
