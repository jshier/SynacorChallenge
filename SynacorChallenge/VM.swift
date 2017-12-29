//
//  VM.swift
//  SynacorChallenge
//
//  Created by Jon Shier on 12/28/17.
//  Copyright © 2017 Jon Shier. All rights reserved.
//

import Foundation

final class VM {
    var memory: [UInt16] = [] {
        didSet {
            if memory.count > 32_768 {
                fatalError("Memory limit exceeded.")
            }
        }
    }
    var instructionPointer = 0
    let program: [UInt16]
    var registers: (UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16, UInt16) = (0, 0, 0, 0, 0, 0, 0, 0)
    var stack: [UInt16] = []
    
    init(binary: Data) {
        var values: [UInt16] = []
        for index in stride(from: 0, to: binary.count, by: 2) {
            binary[index..<index + 2].withUnsafeBytes { (pointer: UnsafePointer<UInt16>) in 
                values.append(pointer.pointee)
            }
        }
        program = values
    }
    
    func run() {
        while instructionPointer < program.count {
            let opCode = OpCode(rawValue: program[instructionPointer])!
            switch opCode {
            case .halt: return
            case .out:
                let character = Character(Unicode.Scalar(program[instructionPointer + 1])!)
                print(character, separator: "", terminator: "")
                instructionPointer += 1
            case .noop: break
//            case .jmp: instructionPointer = Int(program[instructionPointer + 1])
            default:
                fatalError()
            }
            instructionPointer += 1
        }
    }
}

extension Data {
    func scanOpCode(start: Int, length: Int) -> [UInt16] {
        var result: [UInt16] = []
        for index in stride(from: start, to: start + ((length + 1) * 2), by: 2) {
            self[index..<index + 2].withUnsafeBytes { (pointer: UnsafePointer<UInt16>) -> Void in
                result.append(pointer.pointee)
            }
        }
        return result
    }
}

extension Sequence {
    func count(where predicate: (Element) -> Bool) -> Int {
        var count = 0
        for element in self {
            if predicate(element) {
                count += 1
            }
        }
        
        return count
    }
}
