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

class ViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.prepareMapView()
        self.checkAuthorizationStatus()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let identifier = segue.identifier {
            if identifier == "assetViewControllerSegue" {
                let annotationView = sender as! MKAnnotationView
                
                let assetViewController = segue.destinationViewController as! AssetViewController
                assetViewController.annotation = annotationView.annotation as? PhotoAnnotation
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let photoAnnotation = annotation as? PhotoAnnotation
        let photoAnnotationViewID = "photoAnnotationView"
        var photoAnnotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(photoAnnotationViewID) as? PhotoAnnotationView
        
        if photoAnnotationView == nil {
            photoAnnotationView = PhotoAnnotationView(annotation: photoAnnotation, reuseIdentifier: photoAnnotationViewID)
        }
        
        if let image = photoAnnotation?.image {
            photoAnnotationView?.image = image
        } else {
            let screenScale = UIScreen.mainScreen().scale
            let targetSize = CGSize(
                width: PhotoAnnotationView.size.width * screenScale,
                height: PhotoAnnotationView.size.height * screenScale)
            
            PHImageManager().requestImageForAsset(
                photoAnnotation?.asset,
                targetSize: targetSize,
                contentMode: .AspectFill,
                options: nil,
                resultHandler: {(image, info) -> Void in
                    photoAnnotation?.image = image;
                    photoAnnotationView?.thumbnailImage = image;
                }
            )
        }
        
        return photoAnnotationView
    }
    
    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
        let coordinate :CLLocationCoordinate2D = view.annotation.coordinate
        var region :MKCoordinateRegion = mapView.region
        region.center = coordinate
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        self.performSegueWithIdentifier("assetViewControllerSegue", sender: view)
    }
    
    private func prepareMapView() {
        self.mapView.rotateEnabled = false
        self.mapView.pitchEnabled = false
        self.mapView.delegate = self
        
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
                if asset.location != nil {
                    let annotation = PhotoAnnotation(asset: asset)
                    self.mapView.addAnnotation(annotation)
                }
            }
        })
    }
}

