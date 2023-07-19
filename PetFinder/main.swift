//
//  main.swift
//  PetFinder
//
//  Created by Sayam Patel on 6/20/19.
//  Copyright © 2019 Oak City Labs. All rights reserved.
//

import UIKit

// Switch active AppDelegate at startup so as not to create full app instance during unit tests
// http://qualitycoding.org/app-delegate-for-tests/

let delegates: [AnyClass?] = [
    NSClassFromString("PetFinderTests.TestingAppDelegate")
]
let appDelegateClass: AnyClass = delegates.compactMap { $0 }.first ?? AppDelegate.self

UIApplicationMain(CommandLine.argc,
                  CommandLine.unsafeArgv,
                  nil,
                  NSStringFromClass(appDelegateClass))
