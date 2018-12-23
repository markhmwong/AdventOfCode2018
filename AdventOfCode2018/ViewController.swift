//
//  ViewController.swift
//  AdventOfCode2018
//
//  Created by Mark Wong on 20/12/18.
//  Copyright © 2018 Mark Wong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        self.changesInFrequency() //day1
        self.checksum() //day2
    }
    
    //Day 2 Challenge
    func checksum() {
        var day2 = Day2()
        day2.part2()
    }

    //Day 1 Challenge
    func changesInFrequency() {
        let day1 = Day1()
//        day1.part1(dataArr: day1.rawData) //complete
//        print(day1.part2(dataArr: day1.rawData))
    }
    
    
}

