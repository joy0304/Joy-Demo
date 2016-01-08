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
        self.userName = "Daniel"
        self.chatTime = random()%2==1 ? NSDate.init(timeIntervalSince1970: NSTimeInterval(random()%1000)).description : ""
        self.previewImage = UIImage(named: "img_avatar_message_default")
    }
    
    
    class func creatRandomArray(count count:Int) -> [ChatModel] {
        var array = [ChatModel]()
        for _ in 0...(count) {
            let model:ChatModel = ChatModel()
            model.chatFrom = random()%2==0 ? .Me:.Other
            model.userName = model.chatFrom == .Me ? "Daniel":"Sister"
            model.chatTime = random()%2==1 ? NSDate.init(timeIntervalSince1970: NSTimeInterval(random()%1000)).description : ""
            model.previewImage = UIImage(named: "img_avatar_message_default")
            model.chatMessage = ChatModel.randomStr()
            array.append(model)
        }
        return array
    }
    
    class func randomStr() -> String {
        let str:NSMutableString = "Lenovo, which bought Motorola Mobility from Google in 2014, is unifying its two phone businesses under the Lenovo name. It's going to use Motorola's Moto brand for high-end products and its homegrown Vibe brand for budget devices. The Motorola name isn't completely gone. It will live on from a corporate perspective as a division of the Chinese consumer-electronics giant, said Motorola Chief Operating Officer Rick Osterloh."
        let index: Int = random()%100 + 5
        return str.substringToIndex(index)
    }

    
}