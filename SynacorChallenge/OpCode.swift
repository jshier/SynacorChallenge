//
//  OpCode.swift
//  SynacorChallenge
//
//  Created by Jon Shier on 12/28/17.
//  Copyright © 2017 Jon Shier. All rights reserved.
//

enum OpCode: UInt16 {
    case halt = 0
    case set = 1
    case push = 2
    case pop = 3
    case eq = 4
    case gt = 5
    case jmp = 6
    case jt = 7
    case jf = 8
    case add = 9
    case mult = 10
    case mod = 11
    case and = 12
    case or = 13
    case not = 14
    case rmem = 15
    case wmem = 16
    case call = 17
    case ret = 18
    case out = 19
    case `in` = 20
    case noop = 21
}

extension OpCode {
    var captureLength: Int {
        switch self {
        case .halt, .ret, .noop: return 0
        case .set, .jt, .jf, .not, .rmem, .wmem: return 2
        case .push, .pop, .jmp, .call, .out, .in: return 1
        case .eq, .gt, .add, .mult, .mod, .and, .or: return 3
        }
    }
}
