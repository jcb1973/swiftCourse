//
//  ViewController.swift
//  tictactoe
//
//  Created by John Cieslik-Bridgen on 16/01/16.
//  Copyright © 2016 jcb1973. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet var buttons: [UIButton]!
    
    @IBAction func startNewGame(sender: UIButton) {
        gameOver = false
        setUpBlankBoard()
        moveCounter = 0
    }

    @IBAction func buttonClicked(sender: UIButton) {
        
        if gameOver {return}
        
        moveCounter++
        makeMove(sender.tag)
        if moveCounter == 9 {
            endGame()
        }
    
    }
    
    var gameOver = false
    var moveCounter = 0
    var noughtsMove = true
    var noughtsState: [Int] = [0,0,0,0,0,0,0,0,0]
    var crossesState: [Int] = [0,0,0,0,0,0,0,0,0]
    
    var winningCombinations: [[Int]] =
    [
        [1,1,1,0,0,0,0,0,0],
        [0,0,0,1,1,1,0,0,0],
        [0,0,0,0,0,0,1,1,1],
        [1,0,0,0,1,0,0,0,1],
        [1,0,0,1,0,0,1,0,0],
        [0,1,0,0,1,0,0,1,0],
        [0,0,1,0,0,1,0,0,1],
        [0,0,1,0,1,0,1,0,0]
    ]
    
    func makeMove(index: Int) {
        
        var image: UIImage
        var imgName = ""
        
        if noughtsMove {
            imgName = "nought.png"
        } else {
            imgName = "cross.png"
        }
        image = UIImage(named: imgName) as UIImage!
        buttons[index].setImage(image, forState: .Normal)
        buttons[index].enabled = false
        
        if noughtsMove {
            
            noughtsState[index] = 1
            print("noughts has \(noughtsState)")
            checkForWin(noughtsState)
            noughtsMove = false
            
        } else {
            
            crossesState[index] = 1
            print("crosses has \(crossesState)")
            checkForWin(crossesState)
            noughtsMove = true
        
        }
    }
    
    func checkForWin(position: [Int]) {
        
        for combi in winningCombinations {
            var score = 0
            for i in 0...8 {
                
                if (combi[i] == 1 && position[i] == 1) {
                    score++
                    if score == 3 {
                        makeSquaresGreenForCombi(combi)
                        endGame()
                        break
                    }
                }
            }
        }
    }
    
    func endGame() {
        gameOver = true
        newGameButton.hidden = false
    }
    
    func makeSquaresGreenForCombi(winningCombination: [Int]) {
        
        for i in 0...8 {
            if winningCombination[i] == 1 {
                buttons[i].imageView!.backgroundColor = UIColor.greenColor()
            }
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setUpBlankBoard()
    }
    
    func setUpBlankBoard() {
        
        for b in buttons {
            let image = UIImage(named: "Blank.png") as UIImage!
            b.setImage(image, forState: .Normal)
            b.imageView!.backgroundColor = UIColor.clearColor()
        }
        noughtsState = [0,0,0,0,0,0,0,0,0]
        crossesState = [0,0,0,0,0,0,0,0,0]
        
        newGameButton.hidden = true
        noughtsMove = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

