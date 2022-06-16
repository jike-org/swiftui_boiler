//
//  CustomInit.swift
//  Copyright © 2020 ElegantMedia. All rights reserved.
//

import Foundation

extension User {

    init(from: PayloadDictionary?) {
        self._id         = from?["id"] as? String
        self.uuid        = from?["uuid"] as? String
        self.firstName   = from?["first_name"] as? String
        self.lastName    = from?["last_name"] as? String
        self.fullName    = from?["full_name"] as? String
        self.email       = from?["email"] as? String
        self.avatarUrl   = from?["avatar_url"] as? String
        self.timezone    = from?["timezone"] as? String
        self.accessToken = from?["access_token"] as? String
    }
}
