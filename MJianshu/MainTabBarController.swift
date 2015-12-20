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
        addChildVC(FollowViewController(), title: "关注", image: "icon_tabbar_subscription", selected: "icon_tabbar_subscription_active")
        //先设置一个空视图，确保tabbar被五等分
        addChildViewController(UIViewController())
        // 简友
        addChildVC(FriendsViewController(), title: "简友圈", image: "icon_tabbar_activity", selected: "icon_tabbar_activity_active")
        // 我的
        addChildVC(MyViewController(), title: "我的", image: "icon_tabbar_me", selected: "icon_tabbar_me_active")
        // 添加中间按钮
        addCenterButton(btnImage: UIImage(named: "button_write")!, selectedImg: UIImage(named: "button_write")!, selector: "writeArticleButtonClicked", view: view)
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
        childVC.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.orangeColor()], forState:UIControlState.Selected)
        
        // 设置导航控制器
        let childNaviagation = UINavigationController(rootViewController: childVC)
        addChildViewController(childNaviagation)
    }

}

// MARK: - 中间按钮
extension MainTabBarController{
    /**
     //添加TabBar中间按钮
     
     :param: buttonImage 默认状态下图片
     :param: selectedimg 选中状态下图片
     :param: selector    点击按钮调用的方法
     :param: view        这个按钮被加载的视图
     */
    func addCenterButton(btnImage buttonImage: UIImage, selectedImg selectedimg: UIImage, selector: String, view: UIView) {
        let button:UIButton = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(0, 0, tabbarBigImageLength, tabbarBigImageLength)
        button.center = tabBar.center
        view.addSubview(button)

        button.setImage(buttonImage, forState: UIControlState.Normal)
        button.setImage(selectedimg, forState: UIControlState.Selected)

        button.adjustsImageWhenDisabled = true  // 设置选中时阴影
        button.addTarget(self, action: Selector(selector), forControlEvents:UIControlEvents.TouchUpInside)
    }
        
    /**
     点击按钮触发的函数，present写新文章的页面
     */
    func writeArticleButtonClicked() {
        let writeViewController = UIStoryboard(name: "Write", bundle: nil).instantiateViewControllerWithIdentifier("writeViewController")
        self.presentViewController(writeViewController, animated: true, completion: nil)
    }
}

