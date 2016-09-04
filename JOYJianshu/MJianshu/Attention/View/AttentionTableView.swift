//
//  AttentionTableView.swift
//  MJianshu
//
//  Created by heyi on 1/29/16.
//  Copyright © 2016 Martin. All rights reserved.
//

import UIKit

/**
 关注类型
 */
enum AttentionType: String {
    case allAttention = "所有关注"
    case onlySubject = "只看专题"
    case onlyArticle = "只看文集"
    case onlyUser = "只看用户"
    case onlyPush = "只看推送更新"
}

class AttentionTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    /// 默认关注类型为【所有关注】
    var theAttentionType:AttentionType = .allAttention {
        didSet {
            reloadData()
            // 判断是否需求请求最新的数据
            var needRequestData = false
            switch theAttentionType {
                case .allAttention:
                    if allAttentionDatas.count == 0 { needRequestData = true }
                case .onlyArticle:
                    if onlyArticleDatas.count == 0 { needRequestData = true }
                case .onlySubject:
                    if onlySubjectDatas.count == 0 { needRequestData = true }
                case .onlyUser:
                    if onlyUserDatas.count == 0 { needRequestData = true }
                case .onlyPush:
                    if onlyPushDatas.count == 0 { needRequestData = true }
            }
            if needRequestData { requestData(true) }
        }
    }
    
    /// 数据源
    var allAttentionDatas = []
    var onlySubjectDatas = []
    var onlyArticleDatas = []
    var onlyUserDatas = []
    var onlyPushDatas = []
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        
        delegate = self
        dataSource = self
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Private
    
    /**
    重新加载
    - parameter isNew: true:请求最新的数据，false:加载更多的数据
    */
    private func requestData(isNew: Bool) {
        
    }
}

// MARK: - UITableView Delegate DataSource
extension AttentionTableView {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch theAttentionType {
        case .allAttention:
            return allAttentionDatas.count
        case .onlySubject:
            return onlySubjectDatas.count
        case .onlyArticle:
            return onlyArticleDatas.count
        case .onlyUser:
            return onlyUserDatas.count
        case .onlyPush:
            return onlyPushDatas.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
