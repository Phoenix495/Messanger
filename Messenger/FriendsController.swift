//
//  ViewController.swift
//  Messenger
//
//  Created by Phoenix on 07.05.17.
//  Copyright © 2017 Phoenix. All rights reserved.
//

import UIKit


class FriendsController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellID = "cellID"
    
    var messages: [Messege]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Recent"
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.alwaysBounceVertical = true
        
        collectionView?.register(MessegeCell.self, forCellWithReuseIdentifier: cellID)
        
        setupData()
    }

    // налаштування collectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = messages?.count {
            return count
        }
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MessegeCell
        
        if let messege = messages?[indexPath.item] {
            cell.messege = messege
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeMake = CGSize(width: view.frame.width, height: 90.0)
        return sizeMake
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let layout = UICollectionViewFlowLayout()
        let controller = ChatLogController(collectionViewLayout: layout)
        controller.friend = messages?[indexPath.item].friend
        navigationController?.pushViewController(controller, animated: true)
    }
}


class MessegeCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor(red: 0, green: 134/255, blue: 249/255, alpha: 1) : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            messegeLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            timeLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
        }
    }
    
    var messege: Messege? {
        didSet {
            nameLabel.text = messege?.friend?.name
            if let profileImageName = messege?.friend?.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
                hasReadImageView.image = UIImage(named: profileImageName)
            }
            messegeLabel.text = messege?.text
            
            if let date = messege?.date {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss"
                
                let elapsedTimeInSecond = NSDate().timeIntervalSince(date as Date)
                let secondInDays: TimeInterval = 60 * 60 * 24
                
                if elapsedTimeInSecond > 7 * secondInDays {
                    dateFormatter.dateFormat = "dd.MM.yy"
                } else if elapsedTimeInSecond > secondInDays {
                    dateFormatter.dateFormat = "EEE"
                }
                
                timeLabel.text = dateFormatter.string(from: date as Date)
            }
        }
    }
    
    //  конфігурація фотографії друга
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // конфігурація розділової лінії
    let deviderLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    // конфігурація відображення імені
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Friend Name"
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    // конфігурація відображення останнього повідомлення
    let messegeLabel: UILabel = {
        let label = UILabel()
        label.text = "Your friend's messege and something else..."
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    // конфігурація відображення часу відправлення повідомлення
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "16:44"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    // конфігурація відображення аватарки прочитавшого повідомлення
    let hasReadImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    // налаштування всіх додаткових Views
    override func setupViews() {
       
        addSubview(profileImageView)
        addSubview(deviderLineView)
        
        setupContainerView()
        
        profileImageView.image = UIImage(named: "panda")
        hasReadImageView.image = UIImage(named: "panda")
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        
        deviderLineView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraintsWithFormat(format: "H:|-12-[v0(68)]", views: profileImageView)
        addConstraintsWithFormat(format: "V:[v0(68)]", views: profileImageView)
        
        addConstraint(NSLayoutConstraint(item: profileImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        addConstraintsWithFormat(format: "H:|-82-[v0]|", views: deviderLineView)
        addConstraintsWithFormat(format: "V:[v0(1)]|", views: deviderLineView)
        
        
    }
    
    
    // налаштуваня блоку відображення текстової інформації
    private func setupContainerView() {
        let containerView = UIView()
        addSubview(containerView)
        
        addConstraintsWithFormat(format: "H:|-90-[v0]|", views: containerView)
        addConstraintsWithFormat(format: "V:[v0(60)]", views: containerView)
        
        addConstraint(NSLayoutConstraint(item: containerView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(messegeLabel)
        containerView.addSubview(timeLabel)
        containerView.addSubview(hasReadImageView)
        
        
        containerView.addConstraintsWithFormat(format: "H:|[v0][v1(80)]-10-|", views: nameLabel,timeLabel)
        
        containerView.addConstraintsWithFormat(format: "V:|[v0][v1(24)]|", views: nameLabel,messegeLabel)
        
        containerView.addConstraintsWithFormat(format: "H:|[v0]-8-[v1(20)]-12-|", views: messegeLabel,hasReadImageView)
        
        containerView.addConstraintsWithFormat(format: "V:|-10-[v0]", views: timeLabel)
        
        containerView.addConstraintsWithFormat(format: "V:[v0(20)]|", views: hasReadImageView)
    }
}

extension UIView {
    
    func addConstraintsWithFormat(format: String, views: UIView...) {
    
        var viewsDictionary = [String: UIView] ()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

class BaseCell: UICollectionViewCell {
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init(coder eDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor.blue
    }

}
