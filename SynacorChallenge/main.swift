//
//  main.swift
//  SynacorChallenge
//
//  Created by Jon Shier on 12/28/17.
//  Copyright © 2017 Jon Shier. All rights reserved.
//

import Foundation

let vm = VM(binary: try! Data(contentsOf: URL(fileURLWithPath: "/Users/jshier/Desktop/Code/SynacorChallenge/SynacorChallenge/synacor-challenge/challenge.bin")))
vm.run()

