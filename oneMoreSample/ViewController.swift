//
//  ViewController.swift
//  oneMoreSample
//
//  Created by Ashok on 10/7/16.
//  Copyright © 2016 Ashok. All rights reserved.
//

import UIKit

class customCell: UICollectionViewCell {
    
    var circleView: UIView?
    var thumbNailView : UIImageView?
    
    var indexLabel: UILabel?
    var textLabel: UILabel!
    
    func iPadDisplay() {
        
        thumbNailView = UIImageView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width*2/3, height: frame.height*2/3))
        thumbNailView!.layer.cornerRadius = 12.0
        thumbNailView!.center.x = contentView.center.x
        thumbNailView!.layer.borderWidth = 0.5
        thumbNailView!.layer.borderColor = UIColor.black.cgColor
        thumbNailView!.backgroundColor = UIColor.white
        thumbNailView!.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(thumbNailView!)
        
        textLabel = UILabel(frame: CGRect(x: 0, y: thumbNailView!.frame.origin.y + thumbNailView!.frame.size.height, width: frame.size.width, height: frame.size.height/3 - thumbNailView!.frame.origin.y))
        textLabel.font = UIFont.systemFont(ofSize: 20.0)
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
    }
    
    func iPhoneDisplay() {
        
        circleView = UIView(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width*2/3, height: frame.height*2/3))
        circleView!.layer.cornerRadius = circleView!.frame.size.width/2.0
        circleView!.center.x = contentView.center.x
        circleView!.layer.borderWidth = 2.0
        circleView!.layer.borderColor = UIColor.black.cgColor
        circleView!.backgroundColor = UIColor.white
        circleView!.contentMode = UIViewContentMode.scaleAspectFit
        contentView.addSubview(circleView!)
        
        indexLabel = UILabel(frame: CGRect.zero)
        indexLabel!.frame.size.width = circleView!.frame.width
        indexLabel!.frame.size.height = circleView!.frame.height/3.0
        indexLabel!.center.x = circleView!.frame.size.width/2.0
        indexLabel!.center.y = circleView!.frame.size.height/2.0
        indexLabel!.textAlignment = .center
        circleView!.addSubview(indexLabel!)
        
        
        textLabel = UILabel(frame: CGRect(x: 0, y: circleView!.frame.origin.y + circleView!.frame.size.height, width: frame.size.width, height: frame.size.height/3 - circleView!.frame.origin.y))
        textLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
        
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            iPhoneDisplay()
        } else {
            iPadDisplay()
        }
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
    
    var canvasView: UIView! = nil
    var collectionView: UICollectionView! = nil
    var toggleButton: UIButton! = nil
    
    var identifier: String = "Cell"
    var canvasViewHeight: CGFloat = CGFloat()
    var collectionViewHeight: CGFloat = CGFloat()
    var isCanvasViewHidden: Bool = Bool()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let collectionViewFrameSize = CGRect.zero
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        isCanvasViewHidden = false
        
        toggleButton = UIButton(frame: CGRect.zero)
        toggleButton.backgroundColor = UIColor.white
        toggleButton.imageView?.contentMode = .scaleAspectFit
        toggleButton.setImage(UIImage(named: "downArrow"), for: .normal)
        toggleButton.addTarget(self, action: #selector(ViewController.showOrHideCanvasView(sender:)), for: .touchUpInside)
        toggleButton.isUserInteractionEnabled = true
        
        canvasView = UIView(frame: CGRect.zero)
        
        toggleButton.layer.masksToBounds = false
        toggleButton.layer.shadowColor = UIColor.black.cgColor
        toggleButton.layer.shadowOpacity = 2.0
        toggleButton.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        toggleButton.layer.shadowRadius = 1.0
        toggleButton.backgroundColor = UIColor.white
        
        collectionView = UICollectionView(frame: collectionViewFrameSize, collectionViewLayout: layout)
        collectionView.register(customCell.self, forCellWithReuseIdentifier: identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.layer.masksToBounds = false
        collectionView.layer.shadowColor = UIColor.black.cgColor
        collectionView.layer.shadowOpacity = 0.2
        collectionView.layer.shadowOffset = CGSize(width: -1.0, height: -1.0)
        collectionView.layer.shadowRadius = 1.0
        collectionView.backgroundColor = UIColor.white
        
        canvasView.addSubview(toggleButton)
        
        canvasView.addSubview(collectionView)
        self.view .addSubview(canvasView)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        if UIDevice.current.userInterfaceIdiom == .phone {
            
            if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
                canvasViewHeight = CGFloat(self.view.frame.size.width * 16.0 ) / 100.0
            } else {
                canvasViewHeight = CGFloat(self.view.frame.size.width * 30.0 ) / 100.0
            }
            
        } else {
            
            if UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation) {
                canvasViewHeight = CGFloat(self.view.frame.size.width * 20.0 ) / 100.0
            } else {
                canvasViewHeight = CGFloat(self.view.frame.size.width * 28.0 ) / 100.0
            }
            
        }
        
        canvasView.frame.origin.y = self.view.frame.size.height
        
        UIView.animate(withDuration: 1.0) {
            self.canvasView.frame = CGRect(x: 0, y: self.view.frame.height - self.canvasViewHeight, width: self.view.frame.size.width, height: self.canvasViewHeight)
        }
    
        
        toggleButton.frame.size = CGSize(width: 100, height: 35)
        toggleButton.center.x = self.canvasView.center.x
        toggleButton.backgroundColor = UIColor.white
        toggleButton.frame.origin.y = 0
        
        let toggleButtonPath = UIBezierPath()
        toggleButtonPath.move(to: CGPoint(x: 0.0, y: toggleButton.frame.size.height))
        toggleButtonPath.addLine(to: CGPoint(x: 0.0, y: 0.0))
        toggleButtonPath.addLine(to: CGPoint(x: toggleButton.frame.size.width, y: 0.0))
        toggleButtonPath.addLine(to: CGPoint(x: toggleButton.frame.size.width, y: toggleButton.frame.size.height))
        toggleButtonPath.close()
        toggleButton.layer.shadowPath = toggleButtonPath.cgPath
        
        self.collectionViewHeight = self.canvasViewHeight - self.toggleButton.frame.size.height
        
        self.collectionView.frame = CGRect(x: 0, y: self.toggleButton.frame.size.height, width: self.canvasView.frame.width, height: self.canvasView.frame.size.height - self.toggleButton.frame.size.height)
        
        collectionView.collectionViewLayout.invalidateLayout()
        self.view.setNeedsDisplay()
    }
    
    
    //     override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    //     super.viewWillTransition(to: size, with: coordinator)
    //
    //
    //     }
    
    func showOrHideCanvasView(sender: UIButton) {
        
        if isCanvasViewHidden {
            UIView.animate(withDuration: 1.0) {
                self.toggleButton.setImage(UIImage(named: "downArrow"), for: .normal)
                self.canvasView.frame = CGRect(x: 0, y: self.view.frame.height - self.canvasView.frame.size.height, width: self.view.frame.width, height: self.self.canvasView.frame.size.height)
                self.isCanvasViewHidden = false
            }
        } else {
            UIView.animate(withDuration: 1.0) {
                self.toggleButton.setImage(UIImage(named: "upArrow"), for: .normal)
                self.canvasView.frame = CGRect(x: 0, y: self.view.frame.size.height - self.toggleButton.frame.size.height, width: self.view.frame.size.width, height: self.canvasViewHeight)
                self.isCanvasViewHidden = true
            }

        }
        
    }
    
    
    
    @IBAction func showCollectionView(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0) {
            self.canvasView.frame = CGRect(x: 0, y: self.view.frame.height - self.canvasView.frame.size.height, width: self.view.frame.width, height: self.self.canvasView.frame.size.height)
        }
    }
    
    
    @IBAction func hideCollectionView(_ sender: UIButton) {
        UIView.animate(withDuration: 1.0) {
            self.canvasView.frame = CGRect(x: 0, y: self.view.frame.size.height - self.toggleButton.frame.size.height, width: self.view.frame.size.width, height: self.canvasViewHeight)
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
        return 28
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! customCell
        
        cell.backgroundColor = UIColor.white
        cell.textLabel.text = "Text"
        
        //For .phone
        if let tempCircleView = cell.circleView {
            tempCircleView.backgroundColor = UIColor.white
        }
        if let tempLabel = cell.indexLabel {
            tempLabel.text = String(indexPath.row)
            tempLabel.textColor = UIColor.black
        }
        
        //For .pad
        if let tempThumbNailView = cell.thumbNailView {
            tempThumbNailView.image = UIImage(named: "star")
        }
        
        return cell
    }
    
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? customCell
        
        //For .phone
        if let tempCircleView = cell?.circleView {
            tempCircleView.backgroundColor = UIColor.black
        }
        if let tempIndexLabel = cell?.indexLabel {
            tempIndexLabel.textColor = UIColor.white
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? customCell
        
        //For .phone
        if let tempCircleView = cell?.circleView {
            tempCircleView.backgroundColor = UIColor.white
        }
        if let tempIndexLabel = cell?.indexLabel {
            tempIndexLabel.textColor = UIColor.black
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return CGSize(width: collectionViewHeight - 12, height: collectionViewHeight - 12)
        } else {
            return CGSize(width: collectionViewHeight - 20, height: collectionViewHeight - 20)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        //uncomment below line whenerver for minimumLineSpaceing
        //return 12.0
        
        return 0.0
    }
}









