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
        //添加所有子控制器
        addAllChildViewController()
        
    }
}
//子视图
extension MainTabBarController{
    func addAllChildViewController(){
        // 主页
        addChildVC(FindViewController(), title: "发现", image: "recommendation_1", selected: "recommendation_2")
        //关注
        addChildVC(FollowViewController(), title: "关注", image: "classification_1", selected: "classification_2")
        //先设置一个空视图，后面使用Button覆盖
        addChildViewController(UIViewController())
        //简友
        addChildVC(FriendsViewController(), title: "简友圈", image: "broadwood_1", selected: "broadwood_2")
        //我的
        addChildVC(MyViewController(), title: "我的", image: "my_1", selected: "my_2")
        //添加中间按钮
        self.addCenterButton(btnimage: UIImage(named: "collect_2")!, selectedbtnimg: UIImage(named: "collect_2")!, selector: "addWriteView", view: self.view)
        
    }
    
    func addChildVC(childVC:UIViewController,title:String?,image:String,selected:String){
        
        childVC.tabBarItem = UITabBarItem(title: title, image: UIImage(named: image), selectedImage:UIImage(named: selected))
        //设置点击之后的字体颜色
        self.tabBar.tintColor = UIColor.blackColor()
        //设置导航控制器
        let childNaviagation = MainNavigationController(rootViewController: childVC)
        addChildViewController(childNaviagation)
    }

}
    
//中间按钮
extension MainTabBarController{
    
        //添加TabBar中间按钮
        func addCenterButton(btnimage buttonImage:UIImage,selectedbtnimg selectedimg:UIImage,selector:String,view:UIView)
        {
            //创建一个自定义按钮
            let button:UIButton = UIButton(type: UIButtonType.Custom)
            //button大小为适应图片
            button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
            button.setImage(buttonImage, forState: UIControlState.Normal)
            button.setImage(selectedimg, forState: UIControlState.Selected)
            //去掉阴影
            button.adjustsImageWhenDisabled = true;
            //按钮的代理方法
            button.addTarget( self, action: Selector(selector), forControlEvents:UIControlEvents.TouchUpInside )
            //高度差
            let heightDifference:CGFloat = buttonImage.size.height - self.tabBar.frame.size.height
            if (heightDifference < 0){
                button.center = self.tabBar.center;
            }
            else
            {
                var center:CGPoint = self.tabBar.center;
                center.y = center.y - heightDifference/2.0;
                button.center = center;
            }
            view.addSubview(button);
        }
        
        //点击按钮触发
        func addWriteView(){
            
            let writeViewController = UIStoryboard(name: "Write", bundle: nil).instantiateViewControllerWithIdentifier("writeViewController")
            self.presentViewController(writeViewController, animated: true, completion: nil)
            
        }

    }

