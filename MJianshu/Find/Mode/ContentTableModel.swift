//
//  ContentTableModel.swift
//  MJianshu
//
//  Created by wjl on 15/12/26.
//  Copyright © 2015年 Martin. All rights reserved.
//

import Foundation

class Article: NSObject {
    
    var userName: String?
    var previewImage: String?
    var timeValue: String?
    var readNumber: Int?
    var commentNumber: Int?
    var favorNumber: Int?

//    init(userName: String,previewImage: String,timeValue: String,readNumber: Int,commentNumber: Int,favorNumber: Int) {
//        //super.init()
//        self.userName = userName
//        self.previewImage = previewImage
//        self.timeValue = timeValue
//        self.readNumber = readNumber
//        self.commentNumber = commentNumber
//        self.favorNumber = favorNumber
//    }
}

protocol Repository{
    
   // var articles: [Article]{ get }
    
    func loadArticles()->[Article]
    
}

class ArticleRepository: Repository {
    
    var articleArray: NSArray?
    
//    var articles: [Article]{
//        return articleArray
//    }
//    
   // var a: NSArray?
    
    func loadArticles()->[Article] {
        let query = AVQuery(className: "FindContentModel")
        query.whereKey("userName", notEqualTo: " ")
        query.limit = 8
        query.addDescendingOrder("updatedAt")
        let results = query.findObjects() as NSArray
        let temp = results.valueForKey("localData")
        print(temp)
        articleArray = Article.mj_objectArrayWithKeyValuesArray(temp)
        //print("s")
        print(articleArray)
        return articleArray as! [Article]
        //print(articleArray?.firstObject?)
        //print(articleArray?.mj_keyValuesWithKeys("localData" as AnyObject)
//        for i in articleArray as! [Article] {
//            //print(i)
//            print(i.favorNumber)
//        }
    }
}

