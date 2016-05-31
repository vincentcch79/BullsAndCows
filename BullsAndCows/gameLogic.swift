//
//  gameLogic.swift
//  BullsAndCows
//
//  Created by 張智涵 on 2016/5/30.
//  Copyright © 2016年 Brian. All rights reserved.
//

import UIKit
class GameLogic: NSObject {
    
    static var answear: String = ""

    
    
    class func generateAnswear() -> String{
       
        var numArray = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        for _ in 0...3 {
            let n = Int(arc4random_uniform(UInt32(numArray.count)))
            answear = answear + (numArray.removeAtIndex(n))
        }
        return answear
    }
    

    

    class func guessCompare(guessString: String, answear: String)-> (cows: Int, bulls: Int){
    
        
        var guessArr = Array(guessString.characters)
        var ansArr = Array(answear.characters)
        
        var cows: Int = 0
        var bulls: Int = 0
        
        
        
        for r in 0...3{
            if guessArr[r] == ansArr[r]{
                cows += 1
            }else{
                for o in 0...3{
                    if guessArr[r] == ansArr[o]{
                        bulls += 1
                    }
                }
                
            }
     
        }
        return (cows, bulls)
    }
    
    
        
        
}






