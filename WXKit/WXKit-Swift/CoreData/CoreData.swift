//
//  CoreData.swift
//  WXKit
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//


import Foundation
import CoreData

// MARK: protocols

protocol CoreDataKit {

    static var entityName:String {get};

    func deleteInContext(context:NSManagedObjectContext);
}

// MARK: protocol extensions

extension CoreDataKit where Self : NSManagedObject {

    static func createInContext(context:NSManagedObjectContext) -> Self? {
        var instance:Self? = nil
        context.performBlockAndWait { () -> Void in
            instance = NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext: context) as? Self
        }

        return instance
    }

    static func allInstanceInContext(context:NSManagedObjectContext, predicate:NSPredicate? = nil, sortDescriptor:[NSSortDescriptor]? = nil) -> [Self]  {
        var instances:[Self]? = nil

        context.performBlockAndWait { () -> Void in
            let request = self.fetchRequest(predicate, sortDescriptors: sortDescriptor)
            instances = context.fetch(request)
        }

        if let instances = instances {
            return instances
        } else {
            return [Self]()
        }
    }

    static func fetchRequest(predicate:NSPredicate? = nil, sortDescriptors:[NSSortDescriptor]? = nil) -> NSFetchRequest {
        let request = NSFetchRequest(entityName: self.entityName);
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return request;
    }

    func deleteInContext(context:NSManagedObjectContext) {
        context.deleteObject(self)
    }
}

// MARK: extensions

private extension NSManagedObjectContext {
    func fetch<T where T : NSManagedObject>(request : NSFetchRequest) -> [T] {

        let instances = try! self.executeFetchRequest(request)
        return (instances as? [T])!

    }
}

extension NSManagedObject : CoreDataKit {

    static var entityName:String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last! as String
    }
}
