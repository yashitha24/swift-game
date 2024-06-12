//
//  ScoreViewController.swift
//  Exercise4_Yashitha
//
//  Created by Yashitha on 9/19/23.
//

import UIKit

class ScoreViewController: UIViewController {

   

   
    @IBOutlet weak var player1Score1: UIImageView!
    @IBOutlet weak var player1Score2: UIImageView!
    @IBOutlet weak var player1Score3: UIImageView!
    @IBOutlet weak var player2Score1: UIImageView!
    @IBOutlet weak var player2Score2: UIImageView!
    @IBOutlet weak var player2Score3: UIImageView!
    
    var player1CurrentScore: Int = 0
      var player2CurrentScore: Int = 0
    public var Player1Score = 0
    public var Player2Score = 0
    
    override func viewWillAppear(_ animated: Bool) {
        //check the player score and update images according to the score.
        
        
        switch Player1Score {
        case 0 :
            player1Score1.alpha = 0.1
            player1Score2.alpha = 0.1
            player1Score3.alpha = 0.1
        case 1:
            player1Score1.alpha = 1.0
            player1Score2.alpha = 0.1
            player1Score3.alpha = 0.1
        case 2:
            player1Score1.alpha = 1.0
            player1Score2.alpha = 1.0
            player1Score3.alpha = 0.1
        default:
          
            player1Score1.alpha = 1.0
            player1Score2.alpha = 1.0
            player1Score3.alpha = 1.0
        }
        
        switch Player2Score {
        case 0 :
            player2Score1.alpha = 0.1
            player2Score2.alpha = 0.1
            player2Score3.alpha = 0.1
        case 1:
            player2Score1.alpha = 1.0
            player2Score2.alpha = 0.1
            player2Score3.alpha = 0.1
        case 2:
            player2Score1.alpha = 1.0
            player2Score2.alpha = 1.0
            player2Score3.alpha = 0.1
        default:
            player2Score1.alpha = 1.0
            player2Score2.alpha = 1.0
            player2Score3.alpha = 1.0
        }
    }
    
    
    

      override func viewDidLoad() {
          super.viewDidLoad()

          NotificationCenter.default.addObserver(self, selector: #selector(updatePlayer1Score(notification:)), name: NSNotification.Name("Player1Won"), object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(updatePlayer2Score(notification:)), name: NSNotification.Name("Player2Won"), object: nil)
          NotificationCenter.default.addObserver(self, selector: #selector(resetScores), name: NSNotification.Name("restartScores"), object: nil)
      }

      @objc func updatePlayer1Score(notification: NSNotification) {
          if let score = notification.userInfo?["score"] as? Int {
              player1CurrentScore = score
          }
          updateScoreImages(player: 1, score: player1CurrentScore)
      }

      @objc func updatePlayer2Score(notification: NSNotification) {
          if let score = notification.userInfo?["score"] as? Int {
              player2CurrentScore = score
          }
          updateScoreImages(player: 2, score: player2CurrentScore)
      }

      func updateScoreImages(player: Int, score: Int) {
          if player == 1 {
              player1Score1.alpha = score >= 1 ? 1.0 : 0.1
              player1Score2.alpha = score >= 2 ? 1.0 : 0.1
              player1Score3.alpha = score >= 3 ? 1.0 : 0.1
          } else {
              player2Score1.alpha = score >= 1 ? 1.0 : 0.1
              player2Score2.alpha = score >= 2 ? 1.0 : 0.1
              player2Score3.alpha = score >= 3 ? 1.0 : 0.1
          }
      }

      @objc func resetScores() {
          player1CurrentScore = 0
          player2CurrentScore = 0
          updateScoreImages(player: 1, score: 0)
          updateScoreImages(player: 2, score: 0)
      }
  }
