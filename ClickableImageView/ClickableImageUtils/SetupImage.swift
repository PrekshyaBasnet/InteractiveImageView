//
//  SetupImage.swift
//  ClickableImageView
//
//  Created by Prekshya Basnet on 2/7/17.
//  Copyright © 2017 Prekshya Basnet. All rights reserved.
//

import UIKit

protocol CustomScrollViewDelegate {
  func viewSelected(_ selected: Bool, index: Int)
}

class CustomScrollView: UIScrollView {
  var pictureView: PictureView!
  var imageSize: CGSize!
  var imageFrame: CGRect!
  var setZoom: Bool?
  var offsetXScrollView:CGFloat = 0
  var offsetYScrollView:CGFloat = 0
  var customdelegate: CustomScrollViewDelegate?
  
  init(_ rect: CGRect, minZoom:CGFloat , maxZoom:CGFloat) {
    super.init(frame : rect)
    self.pictureView = PictureView()
    self.minimumZoomScale = minZoom
    self.maximumZoomScale = maxZoom
    delegate = self
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    //Set zoom only first time
    if setZoom == nil {
      self.contentSize = imageSize
      //print(view.frame.height, viewheight, scrollView.frame.size.height)
      imageFrame = CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height)
      self.zoom(to: imageFrame, animated: true)
      setZoom = false
    }
  }
  //Sample Image
  func getPictureViewWithPoints(points: [[CGFloat]]?, image: UIImage) {
    imageSize = image.size
    pictureView.setBackgroundImage(image)
    if let point = points {
      pictureView.responsiveImage = SubImageViews(points: point)
      pictureView.addViews(pictureView.responsiveImage.getViews(), color: UIColor.clear)
    }
    pictureView.delegate = self
    self.addSubview(pictureView)
  }
  
  //Create Shape
  func addImageView(points: [[CGPoint]], color: UIColor) {
    removePreviousSubViews() //Every time user creates new instance of SubImageView and tap cannot recognise it so only at last all views need to be drawn so that previous are erased
    pictureView.responsiveImage = SubImageViews(points: points)
    let views = pictureView.responsiveImage.getViews()
    pictureView.addViews(views, color: UIColor.white)
    pictureView.delegate = self
  }
  
  func removePreviousSubViews() {
    for views in pictureView.subviews {
      if !views.isKind(of: UIImageView.self) {
        views.removeFromSuperview()
      }
    }
  }
  
  func centerImage(){
    offsetXScrollView = self.contentOffset.x
    offsetYScrollView = self.contentOffset.y
    //only when the zoom size is overflows from the screen
    if self.contentSize.width < self.frame.size.width{
      //Leading margin for content in scroll view to place at the center horizontally
      offsetXScrollView = ((self.contentSize.width + 2*offsetXScrollView) - self.frame.size.width)/2
    } else if self.contentSize.height < self.frame.size.height{
      //Leading margin for content in scroll view to place at the center horizontally
      offsetYScrollView = ((self.contentSize.height + 2*offsetYScrollView) - self.frame.size.height)/2
    }
    self.setContentOffset(CGPoint(x: offsetXScrollView,y: offsetYScrollView), animated: true)
  }
}

extension CustomScrollView: PictureViewDelegate {
  func viewClicked(_ selected: Bool, index: Int) {
    customdelegate?.viewSelected(selected, index: index)
  }
}

extension CustomScrollView: UIScrollViewDelegate {
  func viewForZooming(in scrollView: UIScrollView) -> UIView? {
    return pictureView
  }
  
  func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
    centerImage()
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    centerImage()
  }
}


