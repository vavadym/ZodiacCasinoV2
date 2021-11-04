//
//  FortunePopUpViewController.swift
//  CaptainCooksCasino
//
//  Created by Vsevolod Shelaiev on 21.10.2021.
//

import UIKit

class FortunePopUpViewController: BaseVC {
    
    
    @IBOutlet weak var bonusImage: UIImageView!
    
    
    var imageView: UIImage = {
        let image = UIImage()
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
//        bonusImage.image = imageView
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.dismiss(animated: true, completion:nil)
//            self.navigationController!.popViewController(animated: true)
        }
    }
}

