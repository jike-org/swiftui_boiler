//
//  Handlers.swift
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation

public typealias iBSActionHandler = (_ status: Bool, _ message: String) -> ()
public typealias iBSCompletionHandler = (_ status: Bool, _ code: Int, _ message: String) -> ()
public typealias iBSCompletionHandlerWithData = (_ status: Bool, _ code: Int, _ message: String, _ data: Any?) -> ()
