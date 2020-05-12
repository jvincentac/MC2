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
        let sb = UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: "PVC") as! pageViewController
        sb.modalPresentationStyle = .fullScreen
        present(sb, animated: true, completion: nil)
    }
}
