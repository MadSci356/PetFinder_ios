//
//  LogMyLogs.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/1/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

class LogMyLogs: MessageLogger {
        
    var metaController: MetaController?
    
    init(metaController: MetaController?) {
        self.metaController = metaController
    }
    
    func startLogger(inLevel: LogControllerLevel) {
        //nothing to do??
    }
    
    func messageLogDebug(message: String, file: StaticString, function: StaticString, line: UInt) {
        print("DEBUG: \(message) \(file) \(function) \(line)")
    }
    func messageLogVerbose(message: String, file: StaticString, function: StaticString, line: UInt) {
        print("\tVERBOSE: \(message) \(file) \(function) \(line)")
    }
    func messageLogInfo(message: String, file: StaticString, function: StaticString, line: UInt) {
        print("\t\tINFO: \(message) \(file) \(function) \(line)")
    }
    func messageLogWarning(message: String, file: StaticString, function: StaticString, line: UInt) {
        print("\t\t\tWARN: \(message) \(file) \(function) \(line)")
    }
    func messageLogError(message: String, file: StaticString, function: StaticString, line: UInt) {
        print("\t\t\t\tERROR: \(message) \(file) \(function) \(line)")
    }

}
