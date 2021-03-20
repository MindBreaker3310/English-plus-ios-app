//
//  EnglishPlusVC.swift
//  EnglishPlus
//
//  Created by Max on 2019/6/8.
//  Copyright © 2019 MAX. All rights reserved.
//

import UIKit

enum Direction{
    case left
    case right
}

class EnglishPlusVC: UIViewController {

    var cardArray:[NewsCard] = []
    var positionArray:[CGFloat] = []
    var displayCardNumber:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if CheckInternet.Connection(){
            getDailyNews()
        }
    }
    
    func Alert (Message: String){
        let alert = UIAlertController(title: "Alert", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func addGestureRecognizer(){
        //let tgr = UITapGestureRecognizer(target: self, action: #selector(self.moveCardLeft))
        //tgr.numberOfTapsRequired = 1
        
        let lsgr = UISwipeGestureRecognizer(target: self, action: #selector(self.moveCardLeft))
        lsgr.direction = .left
        
        let rsgr = UISwipeGestureRecognizer(target: self, action: #selector(self.moveCardRight))
        rsgr.direction = .right
        
        let dsgr = UISwipeGestureRecognizer(target: self, action: #selector(self.moveCardDown))
        dsgr.direction = .down
        //view.addGestureRecognizer(tgr)
        view.addGestureRecognizer(lsgr)
        view.addGestureRecognizer(rsgr)
        view.addGestureRecognizer(dsgr)
    }
    
    @objc func moveCardLeft(){
        changeCards(direction: .left)
    }
    
    @objc func moveCardRight(){
        changeCards(direction: .right)
    }
    
    @objc func moveCardDown(){
        refreshCards()
    }
    
    
    override func viewDidLayoutSubviews() {
        if CheckInternet.Connection(){
            for i in 0...2{ //init the first three cards
                let thisPosition = view.frame.width * 0.05 - view.frame.width + view.frame.width * CGFloat(i)
                positionArray.append(thisPosition)
                let thisCard = NewsCard(frame: CGRect(x: positionArray[i], y: view.frame.height * 0.15, width: view.frame.width * 0.9, height: view.frame.height * 0.7))
                thisCard.tag = i
                thisCard.number = i
                thisCard.backgroundColor = .white
                view.addSubview(thisCard)
                thisCard.titleLabel.text = titleArray[i]
                thisCard.newsImageView.image = newsImageArray[i]
                thisCard.descriptionLabel.text = descriptionArray[i]
                thisCard.readMoreButton.addTarget(self, action: #selector(EnglishPlusVC.buttonAction(_:)), for: .touchUpInside)
                addGestureRecognizer()
                cardArray.append(thisCard)
            }
        }else{
            self.Alert(Message: "No internet connected")
            let thisCard = NewsCard(frame: CGRect(x: view.frame.width * 0.05, y: view.frame.height * 0.15, width: view.frame.width * 0.9, height: view.frame.height * 0.7))
            thisCard.backgroundColor = .white
            view.addSubview(thisCard)
            thisCard.titleLabel.text = "No internet connected"
            thisCard.readMoreButton.setTitle("Sorry :(", for: UIControl.State.normal)
            cardArray.append(thisCard)
        }
        
    }
    
    func changeCards(direction:Direction){
        var current:Int!
        if direction == .left{
            for thisCard in cardArray{
                current = thisCard.tag
                current -= 1
                if current < 0{
                    current = 2
                }
                thisCard.tag = current
                if thisCard.tag == 0 || thisCard.tag == 1{
                    UIView.animate(withDuration: 0.2, animations: {
                        thisCard.frame = CGRect(x: self.positionArray[thisCard.tag], y: self.view.frame.height * 0.15, width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.7)
                    })
                }else{//move to another side
                    thisCard.number = thisCard.number + 3
                    if thisCard.number >= titleArray.count{
                        thisCard.number = thisCard.number - titleArray.count
                    }
                    thisCard.titleLabel.text = titleArray[thisCard.number]
                    thisCard.newsImageView.image = newsImageArray[thisCard.number]
                    thisCard.descriptionLabel.text = descriptionArray[thisCard.number]
                    
                    thisCard.frame = CGRect(x: positionArray[thisCard.tag], y: view.frame.height * 0.15, width: view.frame.width * 0.9, height: view.frame.height * 0.7)
                }
                
                if thisCard.tag == 1{
                    displayCardNumber = thisCard.number
                }
            }
            
        }else{
            for thisCard in cardArray{
                current = thisCard.tag
                current += 1
                if current > 2{
                    current = 0
                }
                thisCard.tag = current
                if thisCard.tag == 1 || thisCard.tag == 2{
                    UIView.animate(withDuration: 0.2, animations: {
                        thisCard.frame = CGRect(x: self.positionArray[thisCard.tag], y: self.view.frame.height * 0.15, width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.7)
                    })
                }else{
                    thisCard.number = thisCard.number - 3
                    if thisCard.number < 0{
                        thisCard.number = thisCard.number + titleArray.count
                    }
                    thisCard.titleLabel.text = titleArray[thisCard.number]
                    thisCard.newsImageView.image = newsImageArray[thisCard.number]
                    thisCard.descriptionLabel.text = descriptionArray[thisCard.number]
                    thisCard.frame = CGRect(x: positionArray[thisCard.tag], y: view.frame.height * 0.15, width: view.frame.width * 0.9, height: view.frame.height * 0.7)
                }
                
                if thisCard.tag == 1{
                    displayCardNumber = thisCard.number
                }
            }
        }
    }
    
    func refreshCards(){
        for thisCard in cardArray{
            UIView.animate(withDuration: 0.2, animations: {
                thisCard.frame = CGRect(x: self.positionArray[thisCard.tag], y: self.view.frame.height, width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.7)
            })
        }
        if CheckInternet.Connection(){
            getDailyNews()
        }
        //delay 0.5sec
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            for thisCard in self.cardArray{
                UIView.animate(withDuration: 0.5, animations: {
                    thisCard.frame = CGRect(x: self.positionArray[thisCard.tag], y: self.view.frame.height * 0.15, width: self.view.frame.width * 0.9, height: self.view.frame.height * 0.7)
                })
            }
        }
    }
    
    var titleArray:[String?] = []
    var descriptionArray:[String?] = []
    var urlArray:[String?] = []
    var newsImageArray:[UIImage?] = []
    
    func getDailyNews() -> Void {
        titleArray = []
        descriptionArray = []
        urlArray = []
        newsImageArray = []
        do{
            let apiAddress = "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=1b497965725d4b759c6ddf774bc1fe87"
            let url = URL(string: apiAddress)
            let downloadData = try Data(contentsOf: url!)
            let json = try JSON(data: downloadData)
            
            for i in 0...9{
                titleArray.append(json["articles"][i]["title"].string)
                descriptionArray.append(json["articles"][i]["description"].string)
                //urlToImageArray.append(json["articles"][i]["urlToImage"].string)
                urlArray.append(json["articles"][i]["url"].string)
                
                if let url = URL(string: json["articles"][i]["urlToImage"].string!){
                    do{
                        let downloadData = try Data(contentsOf: url)
                        self.newsImageArray.append(UIImage(data: downloadData))
                    }catch{
                        print("get news image error")
                    }
                }
            }
        }catch{
            print("get news error")
        }
    }
    
    
    @objc func buttonAction(_ sender:UIButton){
        print(displayCardNumber)
        self.performSegue(withIdentifier: "readNews", sender: sender)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let rmvc = segue.destination as? ReadMoreVC else { return }
        
        rmvc.passedData = self.urlArray[displayCardNumber]
    }
    
}
