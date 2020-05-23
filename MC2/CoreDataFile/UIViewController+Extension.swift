//
//  UIViewController+Extension.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 20/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    func getViewContext () -> NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let container = appDelegate?.persistentContainer
        return container!.viewContext
    }
}
