效果图：

![FinalEffect](https://github.com/Xigtun/SideFilterControllerDemo/blob/master/Screenshots/3E6AB54878F23B2404D256CC723670DF.jpeg)
![image](https://github.com/Xigtun/SideFilterControllerDemo/blob/master/Screenshots/Untitled.gif)


#####分析
效果图类似于一些购物App的侧栏筛选模块，由于筛选点击进去可以选择城市和行业。可以考虑把侧边栏独立出来，使用*present navigation controller*的方式，这样，外边的列表与筛选就分别属于两个*navigationController*了。

####实现步骤：
1. 使用自定义动画，使present达到push的效果
2. 在自定义动画的同时，改变目标controller view 的大小。
3. 在view右侧，点击收起侧边栏

#####自定义动画

按照步骤，新建*PresentAnimation* 实现 *UIViewControllerAnimatedTransitioning*协议

	class PresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {
	    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
	        return transitionTime
	    }
	    
	    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
	        let fromVC: UIViewController = transitionContext.viewController(forKey: .from)!
	        let toVC: UIViewController = transitionContext.viewController(forKey: .to)!
	        let containerView = transitionContext.containerView
	
	        /// 背景截图
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
	
新建*DismissAnimation* :


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

新建自定义动画的*navigationController*

	class FilterNavController: UINavigationController, UIViewControllerTransitioningDelegate {
	    override func viewDidLoad() {
	        super.viewDidLoad()
	
	        self.transitioningDelegate = self
	        self.modalPresentationStyle = .custom
	    }
	
	    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
	        return PresentAnimation()
	    }
	
	    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
	        return DismissAnimation()
	    }
	}
	

然后 *present navigation controller* 就可以实现*push*的效果了

	let nav = FilterNavController.init(rootViewController: FilterController())
    self.present(nav, animated: true, completion: nil)
    
#####接下来实现点击左侧区域收起*FilterController*
  
  考虑在左侧区域的*window*上加一个透明的*view*，给改*view*添加手势
  
	  lazy var leftFilterView: UIView = {
	        let tempView = UIView()
	        tempView.frame = CGRect(x: 0, y: 0, width: leftViewWidth, height: screenHeight)
	        tempView.isUserInteractionEnabled = true
	        tempView.backgroundColor = UIColor.clear
	        let tap = UITapGestureRecognizer.init(target: self, action: #selector(leftItemAction(_:)))
	        tempView.addGestureRecognizer(tap)
	        return tempView
	    }()
	    
通过下面方法添加，每次*FilterController dismiss*的时候，都要从*window*上把该*view*移除

        UIApplication.shared.keyWindow?.addSubview(leftFilterView)
 
 如果像在侧边栏出现的时候隐藏*status bar*，可以添加下面一句：
 
 	DispatchQueue.main.async(execute: {
            if let window = UIApplication.shared.keyWindow {
                window.windowLevel = UIWindowLevelStatusBar
            }
    })
    
   接下来就可以实现自定义的侧边栏样式了。
 