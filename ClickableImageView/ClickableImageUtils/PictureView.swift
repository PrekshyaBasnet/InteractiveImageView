//
//  PictureView.swift
//  ClickableImageView
//
//  Created by Prekshya Basnet on 2/7/17.
//  Copyright © 2017 Prekshya Basnet. All rights reserved.
//

import Foundation

//
//  ResponsiveImage.swift
//  imageViewClick
//
//  Created by Prekshya Basnet on 5/3/16.
//  Copyright © 2016 Vastika. All rights reserved.
//

import UIKit

protocol PictureViewDelegate{
  func viewClicked(_ selected: Bool, index: Int)
}

class PictureView: UIView, UIGestureRecognizerDelegate  {
  var backgroundImageView: UIImageView!
  var selected: [Bool] = []
  var responsiveImage: SubImageViews!
  var delegate : PictureViewDelegate?
  
  
  func setBackgroundImage(_ image: UIImage){
    backgroundImageView = UIImageView(image: image)
    self.frame = backgroundImageView.frame
    self.addSubview(backgroundImageView)
    self.bringSubview(toFront: backgroundImageView)
  }
  
  func addViews(_ views: [UIView], color: UIColor?){
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    tap.delegate = self
    self.addGestureRecognizer(tap)
    for i:Int in 0 ..< views.count{
      let view = views[i]
      view.tag = i+1
      view.backgroundColor = color ?? UIColor.white
      selected.append(false)
      self.addSubview(view)
      self.bringSubview(toFront: view)
    }
  }
  
  func addView(_ view: UIView, tag: Int, color: UIColor?){
  let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
  tap.delegate = self
  self.addGestureRecognizer(tap)
  view.tag = tag
  view.backgroundColor = color ?? UIColor.white
  selected.append(false)
  self.addSubview(view)
  self.bringSubview(toFront: view)
  }
  
    @objc func handleTap(_ tap: UITapGestureRecognizer){
    let index = responsiveImage.isLocatedInBeizer(tap.location(in: tap.view))
    if index.isLocated == true{
      let selectedPart = selected[index.indexOfView]
      selectUnselect(selectedPart, index: index.indexOfView)
      delegate?.viewClicked(!selectedPart,index: index.1)
    }
  }
  
  func selectUnselect(_ selectedPart: Bool, index: Int){
    if selectedPart == false {
      selected[index] = true
    } else {
      selected[index] = false
    }
  }
}
