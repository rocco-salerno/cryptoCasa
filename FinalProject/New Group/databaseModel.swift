//
//  databaseModel.swift
//  Login_Register
//
//  Created by Rocco Salerno on 5/30/18.
//  Copyright © 2018 Rocco Salerno. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

enum DatabaseRef
{
    case root
    case userInfo(uid: String)

    func reference() -> DatabaseReference
    {
        switch self
        {
        case .root:
            return rootRef
        default:
            return rootRef.child(path)
        }
    }


    private var rootRef: DatabaseReference
    {
        return Database.database().reference()
    }

    private var path: String
    {
        switch self
        {
            case .root:
                return ""
            case .userInfo(let uid):
                return "userInfo/\(uid)"
        }
    }

}
