//
//  JSON.swift
//  WXKit
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import Foundation

private extension Array {
    func arrayByAppend(element:Element) -> Array {
        var arr = self
        arr.append(element)
        return arr
    }
}

struct JSON {

    private let jsonObject:AnyObject?

    private var errorStack:[String] = []

    init() {
        self.jsonObject = nil
    }

    init(errorStack:[String]) {
        self.jsonObject = nil
        self.errorStack.appendContentsOf(errorStack)
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

    func hasKey(key:String) -> Bool {
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
                json[key] = JSON(items[key]!)
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
                    return JSON(json)
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
                if let json = dictionary.objectForKey(key) {
                    return JSON(json)
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

    func enumerateJson(enumerator: (key:String, json:JSON)->()) {
        if let json:NSDictionary = value() {
            for (index, dictionary) in json {
                let json = JSON(dictionary)
                if let index = index as? String {
                    enumerator(key: index, json: json)
                }
            }
        }
    }

    func enumerateArray(enumerator: (key:Int, json:JSON)->()) {
        if let array:Array<NSDictionary> = value() {
            for (index, dictionary) in array.enumerate() {
                let json = JSON(dictionary)
                enumerator(key: index, json: json)
            }
        }
    }
}

enum JSONGeneratorType {
    case Array, Dictionary, Others
}

class JSONGenerator : GeneratorType {

    typealias Element = (String, JSON)

    private var arrayIndex: Int = 0

    private let type:JSONGeneratorType

    private var arrayGenerator:IndexingGenerator<[AnyObject]>?

    private var dictionaryGenerator:NSDictionary.Generator?

    init(json:JSON) {
        if let arr:[AnyObject] = json.value() {
            arrayGenerator = arr.generate()
            type = .Array
        } else if let dic:NSDictionary = json.value() {
            dictionaryGenerator = dic.generate()
            type = .Dictionary
        } else {
            type = .Others
        }
    }

    func next() -> JSONGenerator.Element? {
        switch self.type {
        case .Array:
            if let o = self.arrayGenerator?.next() {
                return (String(self.arrayIndex++), JSON(o))
            } else {
                return nil
            }
        case .Dictionary:
            if let d = self.dictionaryGenerator?.next() {
                return (d.key as! String, JSON(d.value))
            } else {
                return nil
            }
        default:
            return nil
        }
    }
}