//
//  MainTabBarController.swift
//  MJianshu
//
//  Created by wjl on 15/12/15.
//  Copyright © 2015年 Martin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addAllChildViewController()
    }
}

// MARK: - 子视图
extension MainTabBarController{
    func addAllChildViewController(){
        // 主页
        addChildVC(FindViewController(), title: "发现", image: "recommendation_1", selected: "recommendation_2")
        // 关注
        addChildVC(FollowViewController(), title: "关注", image: "classification_1", selected: "classification_2")
        //先设置一个空视图，确保tabbar被五等分
        addChildViewController(UIViewController())
        // 简友
        addChildVC(FriendsViewController(), title: "简友圈", image: "broadwood_1", selected: "broadwood_2")
        // 我的
        addChildVC(MyViewController(), title: "我的", image: "my_1", selected: "my_2")
        // 添加中间按钮
        addCenterButton(btnImage: UIImage(named: "collect_2")!, selectedImg: UIImage(named: "collect_2")!, selector: "writeArticleButtonClicked", view: view)
    }
    
    /**
     添加子视图控制器
     
     :param: childVC  NavigationViewController的根视图类型
     :param: title    tabbar item的文字
     :param: image    tabbar item的默认图片的名称
     :param: selected tabbar item的选中状态下图片的名称
     */
    func addChildVC(childVC: UIViewController, title: String?, image: String, selected: String) {
        childVC.tabBarItem = UITabBarItem(title: title, image: UIImage(named: image), selectedImage: UIImage(named: selected))
        //设置点击之后的字体颜色
        tabBar.tintColor = UIColor.blackColor()
        //设置导航控制器
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

