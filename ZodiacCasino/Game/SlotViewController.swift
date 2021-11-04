//
//  SlotViewController.swift
//  SlotDemo
//
//  Created by Vsevolod Shelaiev on 16.08.2021.
//

import UIKit
import AVFoundation
import AVKit

class SlotViewController: BaseVC {
    
    @IBOutlet weak var tableViewFirst: UITableView!
    @IBOutlet weak var tableViewSecond: UITableView!
    @IBOutlet weak var tableViewThird: UITableView!
    @IBOutlet weak var tableViewFourth: UITableView!
    @IBOutlet weak var tableViewFifth: UITableView!
    @IBOutlet weak var verticalShit: PlainVerticalProgressBar!
    
    
    @IBOutlet weak var spinButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var backgroundView: UIImageView!
    
    private var level: Int = Int(Level.shared.level) {
        didSet {
            Level.shared.level = level
            levelButton.setTitle("\(level)", for: .normal)
        }
    }
    
    @IBAction func maxBetTapped(_ sender: UIButton) {
        coinsToBetButton.setTitle("300", for: .normal)
        coinsToBet = 300
    }
    
    @IBOutlet weak var maxWin: UIButton! {
        didSet {
            maxWin.setTitle("0", for: .normal)
        }
    }
    
    
    @IBOutlet weak var musicButton: UIButton!
   
    var player: AVAudioPlayer!
    
    
    @IBAction func musicTapped(_ sender: Any) {
//        if ismusicPlaying == false {
//            backgroundPlayer.cheer()
//            ismusicPlaying = true
//        }else {
//            backgroundPlayer.stop()
//            ismusicPlaying = false
//        }
        if Level.shared.musicOn == false {
            backgroundPlayer.cheer()
            musicButton.setImage(UIImage(named: "soundOn"), for: .normal)
            Level.shared.musicOn = true
        }else {
            backgroundPlayer.stop()
            musicButton.setImage(UIImage(named: "soundOff"), for: .normal)
            Level.shared.musicOn = false
        }
    }
    
    
    @IBAction func goToShopFromCounterButton(_ sender: Any) {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "StoreViewController") as! StoreViewController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    private var sharedLevel: Int = Int(Level.shared.rateLevel) {
        didSet {
////            Level.shared.rateLevel = Float(sharedLevel)
//////            sharedLevelLabel.text = "\(String(sharedLevel))/50"
////            if sharedLevel == 51 {
////                sharedLevel = 0
////                sharedLevelLabel.text = "\(String(sharedLevel))/50"
////                Level.shared.rateLevel = 1
////                self.level += 1
////            }
//            DispatchQueue.main.async {
//                self.verticalShit.setNeedsDisplay()
//            }
        }
    }
    
    @IBOutlet weak var levelButton: UIButton! {
        didSet {
            levelButton.setTitle("\(Level.shared.level)", for: .normal)
        }
    }
    
    @IBOutlet weak var sharedLevelLabel: UILabel! {
        didSet {
            sharedLevelLabel.text = "\(Int(Level.shared.rateLevel))/50"
        }
    }
    
    private var coinsPool = Level.shared.coinsPool {
        didSet {
            Level.shared.coinsPool = coinsPool
            coinsCounterButton.setTitle("\(coinsPool)", for: .normal)
        }
    }
    
    @IBOutlet weak var coinsCounterButton: UIButton! {
        didSet {
            coinsCounterButton.setTitle("\(Level.shared.coinsPool)", for: .normal)
        }
    }
    
    private var arrayOfElements: [UIImage] = []
    var slotsElements: [UIImage] = []
    
    private var numberOfRawsInOneSlot = 30
    private var cellID = "cellID"
    private var tables: [UITableView] {
        [tableViewFirst, tableViewSecond, tableViewThird, tableViewFourth, tableViewFifth]
    }
    
    lazy var scrolledIndices: [Int] = { tables.map { (_) -> Int in
        return Int(0)
    }}()
    
    @IBAction func dismissTapped(_ sender: UIButton) {
        self.navigationController!.popViewController(animated: true)
    }
    
    var maxWinCounter: Int = 0
    
    @IBAction func rollTapped(_ sender: Any) {
        coinsPool = coinsPool - coinsToBet
        
       
        
        let random = Int.random(in: 1...4)
        if random == 3 {
            coinsPool += (coinsToBet*5)
            if maxWinCounter <= coinsToBet*5 {
                maxWinCounter = coinsToBet*5
                maxWin.setTitle("\(maxWinCounter)", for: .normal)
            }
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "WinViewController") as! WinViewController
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            vc.wonChipsLabel.text = String(coinsToBet * 5)
            self.present(vc, animated: true, completion: nil)
        }
    
        
        tables.enumerated().forEach {
            let table = $0.element
            let randomRow = Int.random(in: 3..<numberOfRawsInOneSlot - 1)
            let indexPath = IndexPath(row: randomRow, section: 0)
            table.scrollToRow(at: indexPath, at: .top, animated: true)
            scrolledIndices[$0.offset] = randomRow
        }
        
        checkForLoot()
        sharedLevel += 1
//        DispatchQueue.main.async {
//            self.verticalShit.setNeedsDisplay()
//        }
    }
    
    private var coinsToBet = 25
    
    @IBOutlet weak var coinsToBetButton: UIButton!{
        didSet {
            coinsToBetButton.setTitle("\(coinsToBet)", for: .normal)
        }
    }
    
    @IBAction func bet25MoreCoins(_ sender: UIButton) {
        if coinsToBet < 300 {
            coinsToBet += 25
            coinsToBetButton.setTitle("\(coinsToBet)", for: .normal)
        }
    }
    
    
    @IBAction func bet25LessCoins(_ sender: UIButton) {
        if coinsToBet > 25 {
            coinsToBet -= 25
            coinsToBetButton.setTitle("\(coinsToBet)", for: .normal)
        }
    }
    
    var ismusicPlaying: Bool!
    override func viewDidLoad() {
        super.viewDidLoad()
        ismusicPlaying = false
//        sharedLevelLabel.translatesAutoresizingMaskIntoConstraints = false
//        sharedLevelLabel.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -20).isActive = true
//        levelButton.translatesAutoresizingMaskIntoConstraints = false
//        levelButton.trailingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: -20).isActive = true
        arraysFilling()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: musicButton.bottomAnchor, constant: 20).isActive = true
        stackView.bottomAnchor.constraint(equalTo: spinButton.topAnchor, constant: -32).isActive = true
//        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        backgroundView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        spinButton.translatesAutoresizingMaskIntoConstraints = false
        spinButton.trailingAnchor.constraint(equalTo: musicButton.trailingAnchor,constant: 0).isActive = true
//        spinButton.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
//        spinButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -2).isActive = true
//        spinButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -5).isActive = true
//        spinButton.leadingAnchor.constraint(equalTo: moreButton.trailingAnchor,constant: 20).isActive = true
        tableViewsInit()
    }
    
    private func arraysFilling() {
        for _ in 1...5 {
            slotsElements.forEach { (slot) in
                arrayOfElements.append(slot)
            }
        }
    }
    
    @IBOutlet weak var moreButton: UIButton!
    private func checkForLoot() {
        var compareCounter = 0
        scrolledIndices.enumerated().forEach {
            let firstElement = $0.element
            scrolledIndices.forEach { (element) in
                if element == firstElement {
                    compareCounter += 1
                }
            }
            if compareCounter < 4 { return }
        }
    }
}

extension SlotViewController: UITableViewDelegate, UITableViewDataSource {

    func tableViewsInit() {
        tables.forEach {
            $0.delegate = self
            $0.dataSource = self
            $0.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
            $0.allowsSelection = false
            $0.backgroundColor = .clear
            $0.isUserInteractionEnabled = false
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRawsInOneSlot
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let someView = UIView()
        let someImage = UIImageView(image: arrayOfElements[indexPath.row])
        someImage.translatesAutoresizingMaskIntoConstraints = false
        
        someView.addSubview(someImage)
        someImage.fillSuperview(insets: .init(top: 8, left: 8, bottom: 10, right: 8))
        someImage.contentMode = .scaleAspectFit
        
        cell.backgroundView = someView
        cell.backgroundColor = .clear
        return cell
    }
    
}

