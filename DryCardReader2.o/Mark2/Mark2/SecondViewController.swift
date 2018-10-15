//
//  SecondViewController.swift
//  Mark2
//
//  Created by Carlos H. Orozco-Gonzalez on 8/6/18.
//  Copyright © 2018 Carlos H. Orozco-Gonzalez. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    var transferImage: UIImage!
    var analizedPoint = CGPoint(x: 0.0, y: 0.0)

    //UIImageView - Cropped Picture
    @IBOutlet weak var imageHolder: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageHolder.image = transferImage
        updateDisplayWith(red: 0.0, blue: 0.0, green: 0.0, light: 0.0, chroma: 0.0, hue: 0.0)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //Analyze Button
    @IBAction func analyzeButton(_ sender: Any) {
    
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        getPixelColor(transferImage, analizedPoint).getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        updateDisplayWith(red: red, blue: blue, green: green, light: alpha, chroma: blue, hue: green)
    }
    
    @IBOutlet weak var relativeHumidity: UILabel!
    
    // Screenshot Button
    @IBAction func screenShotButton(_ sender: Any) {
    }
    // RGB Labels
    @IBOutlet weak var R: UILabel!
    @IBOutlet weak var G: UILabel!
    @IBOutlet weak var B: UILabel!
    @IBOutlet weak var rValue: UILabel!
    @IBOutlet weak var gValue: UILabel!
    @IBOutlet weak var bValue: UILabel!
    
    //LCh Labels
    @IBOutlet weak var L: UILabel!
    @IBOutlet weak var C: UILabel!
    @IBOutlet weak var h: UILabel!
    @IBOutlet weak var lValue: UILabel!
    @IBOutlet weak var cValue: UILabel!
    @IBOutlet weak var hValue: UILabel!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func updateDisplayWith(red: CGFloat? = nil, blue: CGFloat? = nil, green: CGFloat? = nil, light: CGFloat? = nil, chroma: CGFloat? = nil, hue: CGFloat? = nil) {
        
        if let redValue = red {
            rValue.text = "\(redValue)"
        }
        
        if let greenValue = green {
            gValue.text = "\(greenValue)"
        }
        
        if let blueValue = blue {
            bValue.text = "\(blueValue)"
        }
        if let lightValue = light {
            lValue.text = "\(lightValue)"
        }
        
        if let chromaValue = chroma {
            cValue.text = "\(chromaValue)"
        }
        
        if let hueValue = hue {
            hValue.text = "\(hueValue)"
        }
        
    }
    
    func getPixelColor(_ image:UIImage, _ point: CGPoint) -> UIColor {
        let cgImage : CGImage = image.cgImage!
        guard let pixelData = CGDataProvider(data: (cgImage.dataProvider?.data)!)?.data else {
            return UIColor.clear
        }
        let data = CFDataGetBytePtr(pixelData)!
        let x = Int(point.x)
        let y = Int(point.y)
        let index = Int(image.size.width) * y + x
        let expectedLengthA = Int(image.size.width * image.size.height)
        let expectedLengthRGB = 3 * expectedLengthA
        let expectedLengthRGBA = 4 * expectedLengthA
        let numBytes = CFDataGetLength(pixelData)
        switch numBytes {
        case expectedLengthA:
            return UIColor(red: 0, green: 0, blue: 0, alpha: CGFloat(data[index])/255.0)
        case expectedLengthRGB:
            return UIColor(red: CGFloat(data[3*index])/255.0, green: CGFloat(data[3*index+1])/255.0, blue: CGFloat(data[3*index+2])/255.0, alpha: 1.0)
        case expectedLengthRGBA:
            return UIColor(red: CGFloat(data[4*index])/255.0, green: CGFloat(data[4*index+1])/255.0, blue: CGFloat(data[4*index+2])/255.0, alpha: CGFloat(data[4*index+3])/255.0)
        default:
            // unsupported format
            return UIColor.clear
        }
    }
}




