//
//  ViewController.swift
//  PhotoMap
//
//  Created by 平屋真吾 on 2014/11/25.
//  Copyright (c) 2014年 Shingo Hiraya. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.mapView.rotateEnabled = false
        self.mapView.pitchEnabled = false
        
        let centerCoordinate = CLLocationCoordinate2D(latitude: 35.681382, longitude: 139.766084)
        let initialSpan = MKCoordinateSpan(latitudeDelta: 0.4, longitudeDelta: 0.4)
        let initialRegion = MKCoordinateRegion(center: centerCoordinate, span: initialSpan)
        self.mapView.setRegion(initialRegion, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

