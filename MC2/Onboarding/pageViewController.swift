//
//  pageViewController.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 11/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import UIKit

class pageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    lazy var allViewController : [UIViewController] = {
        return [
            self.newVc(viewController: "onboarding_1"),
            self.newVc(viewController: "onboarding_2"),
            self.newVc(viewController: "onboarding_3")
        ]
    }()
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        if let firstViewController = allViewController.first {
            setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        self.delegate = self
        configurePageControl()
    }
    
    func configurePageControl() {
        pageControl = UIPageControl(frame: CGRect(x: UIScreen.main.bounds.maxX / 4, y: UIScreen.main.bounds.maxY - 80, width: UIScreen.main.bounds.width / 2, height: 50))
        pageControl.isEnabled = false
        pageControl.numberOfPages = allViewController.count
        pageControl.currentPage = 0
        pageControl.tintColor = .black
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        self.view.addSubview(pageControl)
        
    }
    
    func newVc(viewController : String) -> UIViewController {
        return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(withIdentifier: viewController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIdx = allViewController.firstIndex(of: viewController) else {
            return nil
        }
        
        let prevIdx = viewControllerIdx - 1
        
        guard prevIdx >= 0 else {
            return nil
        }
        
        guard allViewController.count > prevIdx else {
            return nil
        }
        
        return allViewController[prevIdx]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIdx = allViewController.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIdx = viewControllerIdx + 1
        
        guard allViewController.count != nextIdx else {
            return nil
        }
        
        guard allViewController.count > nextIdx else {
            return nil
        }
        
        return allViewController[nextIdx]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let pageContentViewController = pageViewController.viewControllers![0]
        self.pageControl.currentPage = allViewController.firstIndex(of: pageContentViewController)!
    }
}
