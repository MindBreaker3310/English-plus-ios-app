//
//  NewsCard.swift
//  EnglishPlus
//
//  Created by Max on 2019/6/9.
//  Copyright © 2019 MAX. All rights reserved.
//

import UIKit

class NewsCard: UIView{
    var number = 0
    
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var newsImageView = UIImageView()
    var contentLabel = UILabel()
    var readMoreButton = UIButton()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        titleLabel.frame = CGRect(x: 20, y: 0, width: self.frame.width - 40, height: self.frame.height * 0.2)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.numberOfLines = 3
        self.addSubview(titleLabel)
        
        newsImageView.frame = CGRect(x: 0, y: self.frame.height * 0.2, width: self.frame.width, height: self.frame.height * 0.45)
        self.addSubview(newsImageView)
        
        descriptionLabel.frame = CGRect(x: 20, y: self.frame.height * 0.65, width: self.frame.width - 40, height: self.frame.height * 0.25)
        descriptionLabel.font = UIFont.systemFont(ofSize: 17)
        descriptionLabel.numberOfLines = 4
        self.addSubview(descriptionLabel)
        
        readMoreButton.frame = CGRect(x: 0, y: self.frame.height * 0.9, width: self.frame.width, height: self.frame.height * 0.1)
        readMoreButton.setTitle("Read more ...", for: UIControl.State.normal)
        readMoreButton.setTitleColor( .white, for: UIControl.State.normal)
        readMoreButton.isEnabled = true
        readMoreButton.backgroundColor = UIColor(red: 187/255, green: 25/255, blue: 25/255, alpha: 1)
        self.addSubview(readMoreButton)
        
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 10, height: 10)
        self.layer.shadowOpacity = 0.15
        self.layer.masksToBounds = true
    }
 
}
