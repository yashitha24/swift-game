//
//  GameViewController.swift
//  Exercise4_Yashitha
//
//  Created by Yashitha on 9/19/23.
//

import UIKit
import AVFoundation

class GameViewController: UIViewController,UIGestureRecognizerDelegate {
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetGame()
        setRestartTapGesture()
        setFightTapGesture()
        
        scoreVC = self.tabBarController!.viewControllers![1] as? ScoreViewController
        // Do any additional setup after loading the view.
//        playBackgroundMusic()

        
    }


    @IBOutlet weak var fightActionView: UIStackView!
    
    @IBOutlet weak var restartActionView: UIStackView!
    @IBOutlet weak var player1Image: UIImageView!
    
    
    @IBOutlet weak var player2Image: UIImageView!
    
    
    @IBOutlet weak var winnerText: UILabel!
    
    
    @IBOutlet weak var restartImage: UIImageView!
    
    
    @IBOutlet weak var fightImage: UIImageView!
    
    var scoreVC: ScoreViewController?
    
    var allImages =
    
    ["1_Balerion.png", "1_Meraxes.png", "1_Sheepstealer.png", "2_Silverwing.png", "2_Meleys.png", "2_Quicksilver.png", "3_Stormcloud.png", "3_Drogon.png", "3_Viserion.png"]
    var getRandomImage1=""
    var getRandomImage2=""
    var playerOneScore : Int = 0
    var playerTwoScore: Int = 0
    
    func resetGame() {
        playerOneScore = 0
        playerTwoScore = 0
        scoreVC?.Player1Score = 0
        scoreVC?.Player2Score = 0
        player1Image.image = UIImage(named: "0_HOD_logo.png")
        player2Image.image = UIImage(named: "0_HOD_logo.png")
        winnerText.text = "Prepare for the battle!"
    }
    
    
    func setFightTapGesture() {
        let fightTap = UITapGestureRecognizer(target: self, action: #selector(self.fight(_:)))
        fightTap.delegate = self
        self.fightActionView.addGestureRecognizer(fightTap)
    }
    
    func setRestartTapGesture() {
        let restartTap = UITapGestureRecognizer(target: self, action: #selector(self.restartGame(_:)))
        restartTap.delegate = self
        self.restartActionView.addGestureRecognizer(restartTap)
    }
    
    @objc func restartGame(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        resetGame()
        setFightTapGesture()
        self.fightImage.alpha = 1.0
    }
    
    func showWinnerAlert(player: Int) {
        let alert = UIAlertController(title: "Game Over", message: "Player \(player) won! Please click Restart to play again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    func animateWinnerImage(_ imageView: UIImageView) {
        UIView.animate(withDuration: 0.2, animations: {
            imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }) { (finished) in
            UIView.animate(withDuration: 0.2) {
                imageView.transform = CGAffineTransform.identity
            }
        }
    }
    var backgroundAudioPlayer: AVAudioPlayer?
    func playBackgroundMusic() {
        if let bgMusicURL = Bundle.main.url(forResource: "sound", withExtension: "mpeg") {
            do {
                backgroundAudioPlayer = try AVAudioPlayer(contentsOf: bgMusicURL)
                
                // Set to loop indefinitely
                backgroundAudioPlayer?.numberOfLoops = -1
                
                // Play the audio
                backgroundAudioPlayer?.play()
                
            } catch {
                print("Error playing the background music")
            }
        }
    }

    func playSound() {
        if let soundURL = Bundle.main.url(forResource: "won", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                
                // Play the audio
                audioPlayer?.play()
                
                // Set a timer to stop the audio after 2 seconds
                Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { timer in
                    self.audioPlayer?.stop()
                    timer.invalidate()
                }
                
            } catch {
                print("Error playing the sound")
            }
        }
    }

    
    @objc func fight(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        let namesOfDragons = ["1_Balerion.png", "1_Meraxes.png", "1_Sheepstealer.png", "2_Silverwing.png", "2_Meleys.png", "2_Quicksilver.png", "3_Stormcloud.png", "3_Drogon.png", "3_Viserion.png"]
        
        
        repeat {
                   getRandomImage1 = allImages.randomElement() ?? "O_HOD_logo.png"
            self.player1Image.image = UIImage(named: getRandomImage1)
                   
                   getRandomImage2 = allImages.randomElement() ?? "O_HOD_logo.png"
            self.player2Image.image = UIImage(named: getRandomImage2)
               } while getRandomImage1 == getRandomImage2
        
        let dragon1Index = namesOfDragons.firstIndex(of: getRandomImage1)
        let dragon2Index = namesOfDragons.firstIndex(of: getRandomImage2)
        
        let parts = getRandomImage1.components(separatedBy: "_")
        var name1 = ""
        var name2 = ""
        if let mainPart = parts.last {
             name1 = mainPart.components(separatedBy: ".").first ?? ""
        }
        
        let parts1 = getRandomImage2.components(separatedBy: "_")
        if let mainPart = parts1.last {
            name2 = mainPart.components(separatedBy: ".").first ?? ""
        }
        if(dragon1Index != nil && dragon2Index != nil && dragon1Index! < dragon2Index! )
        {
            self.playerOneScore += 1
            scoreVC?.Player1Score = playerOneScore
            if self.playerOneScore >= 3
            {
                self.winnerText.text = "Player 1 won! (\(playerOneScore) - \(playerTwoScore)). \n Restart the game."
                self.fightActionView.gestureRecognizers?.removeAll()
                self.fightImage.alpha = 0.1
                showWinnerAlert(player: 1)

            } else
            {
                self.winnerText.text = "\(name1) is stronger. \n Player 1 wins the round!"
                animateWinnerImage(self.player1Image)
                playSound()
            }
        } else if(dragon1Index != nil && dragon2Index != nil && dragon1Index! > dragon2Index! ) {
            self.playerTwoScore += 1
            scoreVC?.Player2Score = playerTwoScore
            if self.playerTwoScore >= 3
            {
                self.winnerText.text = "Player 2 won! (\(playerOneScore) - \(playerTwoScore)). \n Restart the game."
                self.fightActionView.gestureRecognizers?.removeAll()
                self.fightImage.alpha = 0.1
                showWinnerAlert(player: 2)
                animateWinnerImage(self.player2Image)
            } else
            {
                self.winnerText.text = "\(name2) is stronger. \n Player 2 wins the round!"
                playSound()
            }
        } else {
            self.winnerText.text = "It's a tie"
        }
    }
    
    
      
    

}
