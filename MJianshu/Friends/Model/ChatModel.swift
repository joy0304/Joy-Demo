//
//  ChatModel.swift
//  MJianshu
//
//  Created by wjl on 16/1/8.
//  Copyright © 2016年 Martin. All rights reserved.
//

import Foundation

enum ChatFrom : Int {
    case Me
    case Other
}

class ChatModel: NSObject {
    //发送人
    var chatFrom: ChatFrom = .Me
    var userName: String!
    var chatTime: String!
    var previewImage: UIImage!
    var chatMessage: String?

    class func creatMessageFromMeByText(text:String) -> ChatModel{
        let model = ChatModel()
        model.chatMessage = text
        model.configMeBaseInfo()
        return model
    }
    
    private func configMeBaseInfo() {
        self.chatFrom = .Me
        self.userName = "Martin"
        let formatter = NSDateFormatter()
        formatter.dateFormat = " HH:mm:ss"
        self.chatTime = formatter.stringFromDate(NSDate())
        self.previewImage = UIImage(named: "img_avatar_message_default")
    }
    
    
    class func creatRandomArray(count count:Int) -> [ChatModel] {
        var array = [ChatModel]()
        for _ in 0...(count) {
            let model:ChatModel = ChatModel()
            model.chatFrom = random()%2==0 ? .Me:.Other
            model.userName = model.chatFrom == .Me ? "Martin":"Sister"
            let formatter = NSDateFormatter()
            formatter.dateFormat = " HH:mm:ss"
            model.chatTime = random()%2==1 ? formatter.stringFromDate(NSDate()) : ""
            model.previewImage = UIImage(named: "img_avatar_message_default")
            model.chatMessage = ChatModel.randomStr()
            array.append(model)
        }
        return array
    }
    
    class func randomStr() -> String {
        let str:NSMutableString = "在设计流程中，设计评论是一个重要的环节。无论是在独立的设计团队，还是流动性、多远的设计群组中，它都是整个设计过程中，无法忽略的部分。通过团队的设计评论，在不同成员的审视、评论中得到反馈，让你站在自己以外的角度来看待之前的设计作品，这样可以更好地做设计决策，克服障碍，提升作品也提升自我。"
        let index: Int = random()%100 + 5
        return str.substringToIndex(index)
    }

    
}