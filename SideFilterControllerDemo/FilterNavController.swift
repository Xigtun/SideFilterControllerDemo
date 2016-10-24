//
//  FilterNavController.swift
//  SideFilterControllerDemo
//
//  Created by cysu on 24/10/2016.
//  Copyright © 2016 cysu. All rights reserved.
//

import UIKit

class FilterNavController: UINavigationController, UIViewControllerTransitioningDelegate {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.async(execute: {
            if let window = UIApplication.shared.keyWindow {
                window.windowLevel = UIWindowLevelStatusBar
            }
        })
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DispatchQueue.main.async(execute: {
            if let window = UIApplication.shared.keyWindow {
                window.windowLevel = UIWindowLevelNormal
            }
        })
    }


    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAnimation()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DismissAnimation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

let leftViewWidth: CGFloat = 64.0
let transitionTime: TimeInterval = 0.3
let screenHeight: CGFloat = UIScreen.main.bounds.height
let screenWidth: CGFloat = UIScreen.main.bounds.width

class PresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionTime
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC: UIViewController = transitionContext.viewController(forKey: .from)!
        let toVC: UIViewController = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView

        /// 背景截图 模拟器中不会显示出来
        let tempView = fromVC.view.snapshotView(afterScreenUpdates: false)
        tempView?.frame = fromVC.view.frame

        /// 半透明背景
        let filterView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
        filterView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        tempView?.addSubview(filterView)

        containerView.addSubview(tempView!)
        containerView.addSubview(toVC.view!)

        toVC.view.frame = CGRect(x: screenWidth, y: 0, width: screenWidth - leftViewWidth, height: screenHeight)
        UIView.animate(withDuration: transitionTime, animations: {
            toVC.view.frame.origin.x = 64
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

class DismissAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionTime
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC: UIViewController = transitionContext.viewController(forKey: .from)!

        let containerView = transitionContext.containerView

        let tempView = containerView.subviews.last
        UIView.animate(withDuration: transitionTime, animations: {
            fromVC.view.frame.origin.x = screenWidth
        }) { (finished: Bool) in
            if finished {
                transitionContext.completeTransition(true)
                tempView?.removeFromSuperview()
            }
        }
    }
}
