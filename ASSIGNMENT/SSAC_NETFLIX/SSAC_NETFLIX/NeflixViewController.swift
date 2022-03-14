//
//  NeflixViewController.swift
//  SSAC_NETFLIX
//
//  Created by 김진영 on 2021/09/29.
//

import UIKit

class NeflixViewController: UIViewController {

    @IBOutlet var mainPosterImage: UIImageView!
    @IBOutlet var playButton: UIButton!
    
    var poster: UIImage?
    var posterName: [String] = ["어벤져스엔드게임", "암살", "부산행", "명량","7번방의선물","광해","괴물","국제시장","극한직업","도둑들","베테랑","신과함께인과연","신과함께죄와벌","아바타","알라딘","왕의남자","태극기휘날리며","해운대"]
    var clickedImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        poster = UIImage(named: posterName[Int.random(in: 0...3)])
        mainPosterImage.image = poster
        

        clickedImage = UIImage(named:"play_highlighted")

        playButton.setImage(clickedImage, for: UIControl.State.highlighted)
    }
        

    @IBAction func playButtonClicked(_ sender: UIButton) {

        poster = UIImage(named: posterName[Int.random(in: 0...(posterName.count - 1))])
        mainPosterImage.image = poster
        
    }
    
    
    
    
}
