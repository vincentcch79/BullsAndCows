//
//  GameLogicProtocol.swift
//  BullsAndCows
//
//  Created by 張智涵 on 2016/5/31.
//  Copyright © 2016年 Brian. All rights reserved.
//


protocol GenerateAns{
       
    var answear: String  {get set}
    func generateAnswear()
    func setGame()

}
