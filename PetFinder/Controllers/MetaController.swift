//
//  MetaController.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/25/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import Foundation

/**
 An amalgamation of controllers and objects for the PetFinder App.
 Using this, any ViewControllers or other object that conform to the
 MetaControllerConsumer protocol will have access to all these objects.
 
 - Purpose: Dependency Injection. Makes testing easier. How?
            Can make "fake" controllers comprising of fake objects (with artificial data).
    So that we can test our custom View Controller objects more.
 */
class MetaController {
    
    /// ApiController object that fetches pet data from the PetFinder API and other stu
    var apiController: ApiController? {
        didSet {
            passController(apiController)
        }
    }
    
    var logController: LogController? {
        didSet {
            passController(logController)
        }
    }
    var userController: UserController? {
        didSet {
            passController(userController)
        }
    }
    
    var dataController: DataController? {
        didSet {
            passController(dataController)
        }
    }
    
    func passController(_ target: Any?) {
        if var target = target as? MetaControllerConsumer {
            target.metaController = self
        }
    }
    
}

/**
    Custom classes in the project will conform to this protocol.
    So that they can be accessed needed.
 */
protocol MetaControllerConsumer {
    
    /// This var will need to be set by the
    var metaController: MetaController? { get set }
    var mApi: ApiController? { get }
    var mLog: LogController? { get }
    var mUser: UserController? { get }
    var mData: DataController? { get }
    
}

/// Default implementation of MetaControllerConsumer to return what we need
extension MetaControllerConsumer {
    
    var safeMeta: MetaController? {
        assert(metaController != nil, "Metacontroller nil when accessed via convenience method.")
        return metaController
    }
    
    var mApi: ApiController? {
        let controller = safeMeta?.apiController
        assert(controller != nil, "Api is nil when accessed via convenience method.")
        return controller
    }
    
    var mLog: LogController? {
        let controller = safeMeta?.logController
        assert(controller != nil, "Logger is nil when accessed via convenience method.")
        return controller
    }
    
    var mUser: UserController? {
        let controller = safeMeta?.userController
        assert(controller != nil, "User is nil when access via convience method.")
        return controller
    }
    
    var mData: DataController? {
        let controller = safeMeta?.dataController
        assert(controller != nil, "Data is nil when accessed via convenience method.")
        return controller
    }
    func passMetaController(_ target: AnyObject?) {
        metaController?.passController(target)
    }
}

///Make use of LogController easier as it's a MetaControllerCosumer

extension MetaControllerConsumer {
    var logController: LogController? {
        return metaController?.logController
    }
    
    func verboseLog(_ message: String,
                    _ path: StaticString = #file,
                    _ function: StaticString = #function,
                    _ line: UInt = #line) {
        logController?.verboseLog(message, path, function, line)
    }
    
    func debugLog(_ message: String,
                  _ path: StaticString = #file,
                  _ function: StaticString = #function,
                  _ line: UInt = #line) {
        logController?.debugLog(message, path, function, line)
    }
    
    func infoLog(_ message: String,
                 _ path: StaticString = #file,
                 _ function: StaticString = #function,
                 _ line: UInt = #line) {
        logController?.infoLog(message, path, function, line)
    }
    
    func warningLog(_ message: String,
                    _ path: StaticString = #file,
                    _ function: StaticString = #function,
                    _ line: UInt = #line) {
        logController?.warningLog(message, path, function, line)
    }
    
    func errorLog(_ message: String,
                  _ path: StaticString = #file,
                  _ function: StaticString = #function,
                  _ line: UInt = #line) {
        logController?.errorLog(message, path, function, line)
    }
    
}
