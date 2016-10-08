//
//  ViewController.swift
//  oneMoreSample
//
//  Created by Ashok on 10/7/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class customCell: UICollectionViewCell {
    
    var circleView: UIView!
    var indexLabel: UILabel!
    var textLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        circleView = UIImageView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width*2/3, height: frame.height*2/3))
        circleView.layer.cornerRadius = circleView.frame.size.width/2.0
        circleView.center.x = contentView.center.x
        circleView.layer.borderWidth = 2.0
        circleView.layer.borderColor = UIColor.black.cgColor
        circleView.backgroundColor = UIColor.white
        circleView.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(circleView)
        
        indexLabel = UILabel(frame: CGRect.zero)
        indexLabel.frame.size.width = circleView.frame.width
        indexLabel.frame.size.height = circleView.frame.height/3.0
        indexLabel.center.x = circleView.frame.size.width/2.0
        indexLabel.center.y = circleView.frame.size.height/2.0
        indexLabel.textAlignment = .center
        circleView.addSubview(indexLabel)
        
        
        textLabel = UILabel(frame: CGRect(x: 0, y: circleView.frame.size.height + 4.0, width: frame.size.width, height: frame.size.height/3))
        textLabel.font = UIFont.systemFont(ofSize: UIFont.systemFontSize)
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
    }
    
    /*
     This initializer is called from a storyboard or a xib file. That’s not our case, but we still need to provide init(coder:).
     This initializer in our case never going to be called.
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class ViewController: UIViewController {
    
    var collectionView: UICollectionView! = nil
    var identifier: String = "Cell"
    var collectionViewHeight: CGFloat = CGFloat()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let collectionViewFrameSize = CGRect.zero
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        collectionView = UICollectionView(frame: collectionViewFrameSize, collectionViewLayout: layout)
        collectionView.register(customCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.layer.masksToBounds = false
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOpacity = 0.5
        collectionView.layer.shadowOffset = CGSize(width: -1.0, height: -1.0)
        collectionView.layer.shadowRadius = 1.0
        collectionView.backgroundColor = UIColor.white
        
        self.view .addSubview(collectionView)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
            collectionViewHeight = CGFloat(self.view.frame.size.width * 16.0 ) / 100.0
        } else {
            collectionViewHeight = CGFloat(self.view.frame.size.width * 30.0 ) / 100.0
        }
        
        collectionView.frame.origin.y = self.view.frame.size.height
        
        UIView.animate(withDuration: 1.0) { 
            self.collectionView.frame = CGRect(x: 0, y: self.view.frame.height - self.collectionViewHeight, width: self.view.frame.width, height: self.collectionViewHeight)
        }
        collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
    /*
     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
     super.viewWillTransition(to: size, with: coordinator)
     collectionView.collectionViewLayout.invalidateLayout()
     self.view.setNeedsDisplay()
     }
     */
    
    
    @IBAction func showCollectionView(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0) {
            self.collectionView.frame = CGRect(x: 0, y: self.view.frame.height - self.collectionViewHeight, width: self.view.frame.width, height: self.collectionViewHeight)
        }
    }
    
    
    @IBAction func hideCollectionView(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0) {
            self.collectionView.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.collectionViewHeight)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! customCell
        
        cell.backgroundColor = UIColor.white
        
        cell.textLabel.text = "Text"
        
        cell.circleView.backgroundColor = UIColor.white
        
        cell.indexLabel.text = String(indexPath.row)
        cell.indexLabel.textColor = UIColor.black
        
        return cell
    }
    
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? customCell
        cell?.circleView.backgroundColor = UIColor.black
        cell?.indexLabel.textColor = UIColor.white
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? customCell
        cell?.circleView.backgroundColor = UIColor.white
        cell?.indexLabel.textColor = UIColor.black
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewHeight - 12, height: collectionViewHeight - 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 8.0)
    }
    
}









