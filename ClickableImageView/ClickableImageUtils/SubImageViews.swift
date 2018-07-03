//
//  ImageViewModel.swift
//  ClickableImageView
//
//  Created by Prekshya Basnet on 2/7/17.
//  Copyright © 2017 Prekshya Basnet. All rights reserved.
//

import UIKit

class SubImageViews {
  var imageModel: ImageModel!
  
  init(points: [[CGFloat]]) {
    imageModel = ImageModel(userPoints: points)
  }
  init(points: [[CGPoint]]) {
    imageModel = ImageModel(userPoints: points)
  }
  
  func getPaths()->[UIBezierPath]{
    var arrayOfPaths : [UIBezierPath] = []
    for (index1, csvPoints) in imageModel.coordinates.enumerated() {
      let randomPath = UIBezierPath()
      randomPath.move(to: CGPoint(x: imageModel.coordinates[index1][0].x , y: imageModel.coordinates[index1][0].y))
      for i : Int in stride(from: 1, to: csvPoints.count, by: 1){
        randomPath.addLine(to: CGPoint(x: imageModel.coordinates[index1][i].x , y: imageModel.coordinates[index1][i].y))
      }
      randomPath.close()
      let forRandomPathBounds = randomPath.copy()
      imageModel.randomPathsForBounds.append(forRandomPathBounds as! UIBezierPath)
      randomPath.apply(CGAffineTransform(translationX: -randomPath.bounds.origin.x, y: -randomPath.bounds.origin.y))
      arrayOfPaths.append(randomPath)
    }
    return arrayOfPaths
  }
  
  func getViews() -> [UIView]{
    let paths = getPaths()
    var arrayOfViews: [UIView] = []
    for i:Int in 0 ..< paths.count{
      let view = UIView()
      let shapeLayer = CAShapeLayer()
      shapeLayer.path = paths[i].cgPath
      view.layer.mask = shapeLayer
      view.frame.size.height = paths[i].bounds.size.height
      view.frame.size.width = paths[i].bounds.size.width
      view.frame.origin.x = imageModel.randomPathsForBounds[i].bounds.origin.x
      view.frame.origin.y = imageModel.randomPathsForBounds[i].bounds.origin.y
      arrayOfViews.append(view)
    }
    return arrayOfViews
  }
  
  func isLocatedInBeizer(_ point: CGPoint) -> (isLocated: Bool, indexOfView: Int){
    var pointTransform = point
    let paths = getPaths()
    for i:Int in 0 ..< paths.count{
      let x = point.x - imageModel.randomPathsForBounds[i].bounds.origin.x
      let y = point.y - imageModel.randomPathsForBounds[i].bounds.origin.y
      pointTransform.x = x
      pointTransform.y = y
      if paths[i].contains(pointTransform){
        return (true, i)
      }
    }
    return (false, paths.count+1)
  }
}
