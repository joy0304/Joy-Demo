//
//  MainTabBarController.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    let tabbarBigImageLength: CGFloat = 43
    let centerButtonIndex = 2
    var button: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        addAllChildViewController()
    }
    
}

// MARK: - 子视图
extension MainTabBarController{
    func addAllChildViewController(){
        // 主页
        addChildVC(FindViewController(), title: "发现", image: "icon_tabbar_home", selected: "icon_tabbar_home_active")
        // 关注
        addChildVC(AttentionViewController(), title: "关注", image: "icon_tabbar_subscription", selected: "icon_tabbar_subscription_active")
        // 添加中间的按钮
        addCenterButton(imageName: "button_write")
        // 简友
        addChildVC(FriendsViewController(), title: "简友圈", image: "icon_tabbar_activity", selected: "icon_tabbar_activity_active")
        // 我的
        addChildVC(MyViewController(), title: "我的", image: "icon_tabbar_me", selected: "icon_tabbar_me_active")
    }
    
    /**
     添加子视图控制器
     
     :param: childVC  NavigationViewController的根视图类型
     :param: title    tabbar item的文字
     :param: image    tabbar item的默认图片的名称
     :param: selected tabbar item的选中状态下图片的名称
     */
    func addChildVC(childVC: UIViewController, title: String?, image: String, selected: String) {
        childVC.tabBarItem.title = title
        childVC.tabBarItem.image = UIImage(named: image)
        childVC.tabBarItem.selectedImage = UIImage(named: selected)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        // 设置点击之后字体的颜色
        childVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: ColorManger.mainColor()], forState:UIControlState.Selected)
        
        // 设置导航控制器
        let childNaviagation = UINavigationController(rootViewController: childVC)
        addChildViewController(childNaviagation)
    }
}

// MARK: - 中间按钮
extension MainTabBarController{
    /**
     点击按钮触发的函数，present写新文章的页面
     */
    func writeArticleButtonClicked() {
        let currentSelectedIndex = selectedIndex  // 当前选中的tabbarItem的index
        let tempView = viewControllers![currentSelectedIndex].view  // 当前显示的view
        
        if let writeViewController = UIStoryboard(name: "Write", bundle: nil).instantiateViewControllerWithIdentifier("writeViewController") as? WriteViewController {
            viewControllers![centerButtonIndex].view.addSubview(tempView)  // 用当前的view覆盖centerButton背后的view，防止出现黑屏
            
            writeViewController.dismissViewControllerBlock = { [weak self] in
                self?.selectedIndex = currentSelectedIndex  // dismiss之前先切换到当前页面
            }
            self.presentViewController(writeViewController, animated: true, completion: nil)
        }
    }
    
    /**
     添加中间的图片按钮
     
     :param: imageName 图片名称
     */
    func addCenterButton(imageName imageName: String) {
        let containerVC = UIViewController()
        let buttonImage = UIImage(named: imageName)?.imageWithRenderingMode(.AlwaysOriginal)
        
        containerVC.tabBarItem.image = buttonImage
        containerVC.tabBarItem.tag = 2
        containerVC.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0)
        
        let childNaviagation = UINavigationController(rootViewController: containerVC)
        addChildViewController(childNaviagation)
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        switch item.tag {
        case centerButtonIndex: writeArticleButtonClicked()
        default: break
        }
    }
}

