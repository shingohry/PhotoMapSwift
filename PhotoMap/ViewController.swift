//
//  ViewController.swift
//  PhotoMap
//
//  Created by 平屋真吾 on 2014/11/25.
//  Copyright (c) 2014年 Shingo Hiraya. All rights reserved.
//

import UIKit
import MapKit
import Photos

class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.prepareMapView()
        self.checkAuthorizationStatus()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func prepareMapView() {
        self.mapView.rotateEnabled = false
        self.mapView.pitchEnabled = false
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: 35.681382, longitude: 139.766084)
        let initialSpan = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        let initialRegion = MKCoordinateRegion(center: centerCoordinate, span: initialSpan)
        self.mapView.setRegion(initialRegion, animated: true)
    }
    
    private func checkAuthorizationStatus() {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .Authorized:
            self.prepareAnnotations()
        default:
            PHPhotoLibrary.requestAuthorization{ status in
                if status == .Authorized {
                    self.prepareAnnotations()
                }
            }
        }
    }
    
    private func prepareAnnotations() {
        let fetchResult = PHAsset.fetchAssetsWithMediaType(PHAssetMediaType.Image, options: nil)
        fetchResult?.enumerateObjectsUsingBlock ({result, index, stop in
            
            if let asset = result as? PHAsset {
                if let location = asset.location {
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }
}

