//
//  FortuneViewController.swift
//  CaptainCooksCasino
//
//  Created by Vsevolod Shelaiev on 21.10.2021.
//

import UIKit
import SwiftFortuneWheel

class FortuneViewController: BaseVC {
    
    @IBOutlet weak var wheel: SwiftFortuneWheel!

    let imageViewBackTomorrow = UIImage(named: "backTomorrow")
    let imageViewLuckyYou = UIImage(named: "luckyYou")
    
    
    
    @IBAction func backTomain(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var slices: [Slice] = []
        
        let textColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: .black)
        let font = UIFont.systemFont(ofSize: 10, weight: .bold)
        let prefenreces = TextPreferences(textColorType: textColorType,
                                          font: font,
                                          verticalOffset: 10)
        
        
        let imagePreferences = ImagePreferences(preferredSize: CGSize(width: 40, height: 40), verticalOffset: 40)
        let imageSliceContent = Slice.ContentType.assetImage(name: "Element3", preferences: imagePreferences)
        let imageSliceContent1 = Slice.ContentType.assetImage(name: "Element1", preferences: imagePreferences)
        let imageSliceContent2 = Slice.ContentType.assetImage(name: "Element2", preferences: imagePreferences)
        let imageSliceContent3 = Slice.ContentType.assetImage(name: "Element4", preferences: imagePreferences)
        let imageSliceContent4 = Slice.ContentType.assetImage(name: "Element5", preferences: imagePreferences)
        let imageSliceContent5 = Slice.ContentType.assetImage(name: "Element6", preferences: imagePreferences)

        let slice = Slice(contents: [imageSliceContent])
        let slice1 = Slice(contents: [imageSliceContent1])
        let slice2 = Slice(contents: [imageSliceContent2])
        let slice3 = Slice(contents: [imageSliceContent3])
        let slice4 = Slice(contents: [imageSliceContent4])
        let slice5 = Slice(contents: [imageSliceContent5])
        
        slices.append(slice)
        slices.append(slice1)
        slices.append(slice2)
        slices.append(slice3)
        slices.append(slice4)
        slices.append(slice5)
        
        wheel.configuration = .defaultConfiguration
        wheel.slices = slices
        
        wheel.isPinHidden = false
//        wheel.
        wheel.startRotationAnimation(finishIndex: 0, continuousRotationTime: 1) { (finished) in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FortunePopUpViewController") as! FortunePopUpViewController
//                   
//                    vc.imageView = self.imageViewLuckyYou!
                       Level.shared.coinsPool += 500
                       Level.shared.getBonus = true
//                  
                   vc.modalTransitionStyle = .crossDissolve
                   vc.modalPresentationStyle = .overFullScreen
                   self.present(vc, animated: true, completion: nil)
                }
        
    }
    
}

extension SFWConfiguration {
    static var defaultConfiguration: SFWConfiguration {
//        let blueColor = UIColor.init(red: 10/255, green: 62/255, blue: 229/255, alpha: 100)
        let redCustomColor = UIColor(red: 176/255, green: 38/255, blue: 26/255, alpha: 100)
        let sliceColorType = SFWConfiguration.ColorType.evenOddColors(evenColor: .white, oddColor: redCustomColor)
        
//        let sliceAnchorImages = SFWConfiguration.AnchorImage(imageName: "cornerImage", size: CGSize(width: 5, height: 5))
//
        let slicePreferences = SFWConfiguration.SlicePreferences(backgroundColorType: sliceColorType, strokeWidth: 1.5, strokeColor: .lightGray)
        
        let circlePreferences = SFWConfiguration.CirclePreferences(strokeWidth: 10, strokeColor: .clear)
        
        
        var wheelPreferences = SFWConfiguration.WheelPreferences(circlePreferences: circlePreferences, slicePreferences: slicePreferences, startPosition: .bottom)
        wheelPreferences.imageAnchor = SFWConfiguration.AnchorImage(imageName: "imageCorner", size: CGSize(width: 8, height: 8), verticalOffset: -5)
        var pinPreferences = SFWConfiguration.PinImageViewPreferences(size: CGSize(width: 20, height: 20), position: .bottom)
//        pinPreferences.backgroundColor = .brown
        pinPreferences.verticalOffset = 30
        var spinButtonPreferences = SFWConfiguration.SpinButtonPreferences(size: CGSize(width: 30, height: 30))
//        spinButtonPreferences.backgroundColor = .blue
        
//        let configuration = SFWConfiguration(wheelPreferences: wheelPreferences)
        spinButtonPreferences.verticalOffset = 150
        let configuration2 = SFWConfiguration(wheelPreferences: wheelPreferences, pinPreferences: pinPreferences, spinButtonPreferences: spinButtonPreferences)

        return configuration2
    }
}
