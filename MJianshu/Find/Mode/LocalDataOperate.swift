//
//  LocalDataOperate.swift
//  MJianshu
//
//  Created by wjl on 15/12/30.
//  Copyright © 2015年 Martin. All rights reserved.
//

import Foundation
import CoreData

class LocalDataOperate: NSObject {

    
    class func DBAppdelegateObject()->AppDelegate{
        
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    //获取数据
    class func loadModel(completion: (data: [Articles]?, error: NSError?) -> ()){
        
        var articlesArray = [Articles]()
        //1
        let appDelegate = DBAppdelegateObject()
        //2
        let fetchRequest = NSFetchRequest(entityName: "Articles")
        fetchRequest.returnsObjectsAsFaults = false
        //3
        do {
            let results =
            try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest)
            
            articlesArray = results as! [Articles]
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        completion(data: articlesArray, error: nil)
    }
    
    //插入数据
    class func insertData(article: Article){
        
        //1
        let appDelegate = DBAppdelegateObject()
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Articles",
            inManagedObjectContext:managedContext)
        
        let articles = Articles(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        articles.userName = article.userName
        articles.articleTitle = article.articleTitle
        articles.previewImageStr = article.previewImageStr
        articles.timeValue = article.timeValue
        articles.readNumber = article.readNumber
        articles.commentNumber = article.commentNumber
        articles.favorNumber = article.favorNumber
        
        //4
        do {
            try managedContext.save()
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
        
    }
    

    
}
