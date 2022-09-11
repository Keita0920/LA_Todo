//
//  Memo.swift
//  todo
//
//  Created by K I on 2022/09/08.
//

import Foundation
import RealmSwift

class Memo:Object{
    @objc dynamic var title:String=""
    @objc dynamic var content:String=""
    @objc dynamic var date:String=""
}
