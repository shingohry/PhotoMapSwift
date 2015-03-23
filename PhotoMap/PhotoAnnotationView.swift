//
//  PhotoAnnotationView.swift
//  PhotoMap
//
//  Created by hiraya.shingo on 2015/03/23.
//  Copyright (c) 2015年 Shingo Hiraya. All rights reserved.
//

import UIKit
import MapKit

class PhotoAnnotationView: MKAnnotationView {
    class var size :CGSize {
        return CGSize(width: 44.0, height: 44.0)
    }
    
    var thumbnailImage: UIImage? {
        didSet {
            self.thumbnailImageView.image = self.thumbnailImage
        }
    }
    
    private let thumbnailImageView: UIImageView!
    
    override init(annotation: MKAnnotation!, reuseIdentifier: String!) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        self.frame = CGRect(origin: self.frame.origin, size: PhotoAnnotationView.size)
        
        self.canShowCallout = true
        self.rightCalloutAccessoryView = UIButton.buttonWithType(.DetailDisclosure) as UIView
        
        self.thumbnailImageView = UIImageView(frame: CGRect(origin: CGPointZero, size: PhotoAnnotationView.size))
        self.thumbnailImageView.contentMode = .ScaleAspectFill
        self.thumbnailImageView.clipsToBounds = true
        self.addSubview(self.thumbnailImageView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func prepareForReuse() {
        self.thumbnailImage = nil
    }
}
