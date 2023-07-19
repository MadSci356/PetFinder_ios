//
//  LogController.swift
//  PetFinder
//
//  Created by Sayam Patel on 7/1/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

enum LogControllerLevel: Int {
    case all = 0 //what's up danger
    case debug = 1 //more events and data
    case verbose = 2 //events and data
    case info = 3 //events starting/ending
    case warning = 4 //something might go wrong
    case error = 5 //something has gone wrong
    case off = 6 //everything is a feature
    
    func isActive(withRespectTo reflevel: LogControllerLevel) -> Bool {
        return reflevel.rawValue <= rawValue
    }
}

protocol MessageLogger {
    func startLogger(inLevel: LogControllerLevel)
    
    func messageLogDebug(message: String, file: StaticString, function: StaticString, line: UInt)
    func messageLogVerbose(message: String, file: StaticString, function: StaticString, line: UInt)
    func messageLogInfo(message: String, file: StaticString, function: StaticString, line: UInt)
    func messageLogWarning(message: String, file: StaticString, function: StaticString, line: UInt)
    func messageLogError(message: String, file: StaticString, function: StaticString, line: UInt)
    
}

class LogController: MetaControllerConsumer {
    
    var level: LogControllerLevel = .info
    
    weak var metaController: MetaController?
    
    private var messageLoggers = [MessageLogger]()
    
    private(set) var hasStarted = false
    
    init(metaController: MetaController?) {
        self.metaController = metaController
        let defaultLogger = LogMyLogs(metaController: metaController)
        registerLogger(logger: defaultLogger)
    }
    
    func start(level inLevel: LogControllerLevel = .debug) {
        
        guard hasStarted == false else {
            return
        }
        level = inLevel
        
        let bundleId = Bundle.main.bundleIdentifier ?? ""
        let appName = Bundle(identifier: bundleId)?
            .object(forInfoDictionaryKey: kCFBundleExecutableKey as String)
            as? String ?? ""
        
        for mLogger in messageLoggers {
            mLogger.startLogger(inLevel: inLevel)
        }
        
        infoLog("Log starting with Bonjour name: \(appName)")
        hasStarted = true
    }
    
    func registerLogger(logger: MessageLogger) {
        messageLoggers.append(logger)
        if hasStarted {
            logger.startLogger(inLevel: level)
        }
    }
    
    func stop() {
        guard hasStarted else {     // don't double stop
            return
        }
        hasStarted = false
    }
    
    func debugLog(_ message: String,
                  _ path: StaticString = #file,
                  _ function: StaticString = #function,
                  _ line: UInt = #line) {
        guard LogControllerLevel.debug.isActive(withRespectTo: level) else {
            return
        }
        for logger in messageLoggers {
            logger.messageLogDebug(message: message, file: path, function: function, line: line)
        }
    }
    
    func verboseLog(_ message: String,
                    _ path: StaticString = #file,
                    _ function: StaticString = #function,
                    _ line: UInt = #line) {
        guard LogControllerLevel.verbose.isActive(withRespectTo: level) else {
            return
        }
        for logger in messageLoggers {
            logger.messageLogVerbose(message: message, file: path, function: function, line: line)
        }
    }
    
    func infoLog(_ message: String,
                 _ path: StaticString = #file,
                 _ function: StaticString = #function,
                 _ line: UInt = #line) {
        guard LogControllerLevel.info.isActive(withRespectTo: level) else {
            return
        }
        for logger in messageLoggers {
            logger.messageLogInfo(message: message, file: path, function: function, line: line)
        }
    }
    
    func warningLog(_ message: String,
                    _ path: StaticString = #file,
                    _ function: StaticString = #function,
                    _ line: UInt = #line) {
        guard LogControllerLevel.warning.isActive(withRespectTo: level) else {
            return
        }
        for logger in messageLoggers {
            logger.messageLogWarning(message: message, file: path, function: function, line: line)
        }
    }
    
    func errorLog(_ message: String,
                  _ path: StaticString = #file,
                  _ function: StaticString = #function,
                  _ line: UInt = #line) {
        guard LogControllerLevel.error.isActive(withRespectTo: level) else {
            return
        }
        for logger in messageLoggers {
            logger.messageLogError(message: message, file: path, function: function, line: line)
        }
    }
    
}
