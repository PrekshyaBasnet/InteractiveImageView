//
//  ImageModel.swift
//  ClickableImageView
//
//  Created by Prekshya Basnet on 2/7/17.
//  Copyright © 2017 Prekshya Basnet. All rights reserved.
//

import UIKit

class ImageModel {
  var coordinates: [[(x: CGFloat,y: CGFloat)]] = []
  var randomPathsForBounds: [UIBezierPath] = []
  
  // For Images from points
  init(userPoints: [[CGFloat]]) {
    var arrayOfPoints : [[(x: CGFloat,y: CGFloat)]] = []
    var point:(x: CGFloat, y: CGFloat)
    for (index, csvPoints) in userPoints.enumerated() {
      var arrayPoint : [(x: CGFloat, y: CGFloat)] = []
      for i : Int in stride(from: 0, to: csvPoints.count, by: 2){
        point = (x: userPoints[index][i],y: userPoints[index][i+1])
        arrayPoint.append(point)
      }
      arrayOfPoints.append(arrayPoint)
    }
    coordinates = arrayOfPoints
  }
  
  // For My Image and Take Photos
  init(userPoints: [[CGPoint]]) {
    var arrayOfPoints : [[(x: CGFloat,y: CGFloat)]] = []
    var point:(x: CGFloat, y: CGFloat)
    for csvPoints in userPoints {
      var arrayPoint : [(x: CGFloat, y: CGFloat)] = []
      for points in csvPoints {
        point = (x: points.x,y: points.y)
        arrayPoint.append(point)
      }
      arrayOfPoints.append(arrayPoint)
    }
    coordinates = arrayOfPoints
  }
  
}
