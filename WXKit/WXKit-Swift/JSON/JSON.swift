//
//  JSON.swift
//  WXKit
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import Foundation

private extension Array {
    func arrayByAppend(_ element:Element) -> Array {
        var arr = self
        arr.append(element)
        return arr
    }
}

struct JSON {

    fileprivate let jsonObject:AnyObject?

    fileprivate var errorStack:[String] = []

    init() {
        self.jsonObject = nil
    }

    init(errorStack:[String]) {
        self.jsonObject = nil
        self.errorStack.append(contentsOf: errorStack)
    }

    init(_ json:AnyObject?) {
        self.jsonObject = json
    }

    func value<T>() -> T? {
        if let value = jsonObject as? T {
            return value
        }
        return nil
    }

    var error:[String] {
        return errorStack
    }

    var raw:AnyObject? {
        return jsonObject
    }

    var string:String {
        if let value:String = value() {
            return value
        }
        return ""
    }

    var int:Int {
        if let value:Int = value() {
            return value
        }
        return 0
    }

    var double:Double {
        if let value:Double = value() {
            return value
        }
        return 0
    }

    var stringOrNil:String? {
        return value()
    }

    var intOrNil:Int? {
        return value()
    }

    var doubleOrNil:Double? {
        return value()
    }

    func hasKey(_ key:String) -> Bool {
        if let json:NSDictionary  = value() {
            if let _ = json[key] {
                return true
            }
        }
        return false
    }

    func array<T>() -> [T] {
        if let value:Array<T> = value() {
            return value;
        }
        return [T]()
    }

    func jsonArray() -> [JSON] {
        if let value:Array<NSDictionary> = value() {
            return value.map({ item -> JSON in
                return JSON(item)
            })
        }
        return [JSON]()
    }

    func json() -> Dictionary<String, JSON> {
        if let items:NSDictionary = value() {
            var json = Dictionary<String, JSON>()
            for obj in items.allKeys {
                let key = obj as! String;
                json[key] = JSON(items[key]! as AnyObject?)
            }
            return json
        }
        return [String:JSON]()
    }

    subscript(index: Int) -> JSON {
        get {

            if let arr:NSArray = value() {
                if index < arr.count {
                    let json = arr[index]
                    return JSON(json as AnyObject?)
                } else {
                    return JSON(errorStack: errorStack.arrayByAppend("Array[\(index)] is out of bound" ))
                }
            }
            return JSON(errorStack: errorStack.arrayByAppend("Array[\(index)] failed, not an array"))

        }
    }

    subscript(key: String) -> JSON {
        get {
            if let dictionary:NSDictionary = value() {
                if let json = dictionary.object(forKey: key) {
                    return JSON(json as AnyObject?)
                } else {
                    return JSON(errorStack:  errorStack.arrayByAppend("Dictionary[\(key)] does not exist"))
                }
            }
            return JSON(errorStack:  errorStack.arrayByAppend("Dictionary[\(key)] failed, not a dictionary"))
        }
    }


    func generate() -> JSONGenerator {
        return JSONGenerator(json: self)
    }

    func enumerateJson(_ enumerator: (_ key:String, _ json:JSON)->()) {
        if let json:NSDictionary = value() {
            for (index, dictionary) in json {
                let json = JSON(dictionary as AnyObject?)
                if let index = index as? String {
                    enumerator(index, json)
                }
            }
        }
    }

    func enumerateArray(_ enumerator: (_ key:Int, _ json:JSON)->()) {
        if let array:Array<NSDictionary> = value() {
            for (index, dictionary) in array.enumerated() {
                let json = JSON(dictionary)
                enumerator(index, json)
            }
        }
    }
}

enum JSONGeneratorType {
    case array, dictionary, others
}

class JSONGenerator : IteratorProtocol {

    typealias Element = (String, JSON)

    fileprivate var arrayIndex: Int = 0

    fileprivate let type:JSONGeneratorType

    fileprivate var arrayGenerator:IndexingIterator<[AnyObject]>?

    fileprivate var dictionaryGenerator:NSDictionary.Iterator?

    init(json:JSON) {
        if let arr:[AnyObject] = json.value() {
            arrayGenerator = arr.makeIterator()
            type = .array
        } else if let dic:NSDictionary = json.value() {
            dictionaryGenerator = dic.makeIterator()
            type = .dictionary
        } else {
            type = .others
        }
    }

    func next() -> JSONGenerator.Element? {
        switch self.type {
        case .array:
            if let o = self.arrayGenerator?.next() {
                return (String(self.arrayIndex + 1), JSON(o))
            } else {
                return nil
            }
        case .dictionary:
            if let d = self.dictionaryGenerator?.next() {
                return (d.key as! String, JSON(d.value as AnyObject?))
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}
