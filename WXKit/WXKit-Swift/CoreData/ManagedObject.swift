//
//  ManagedObjectContext.swift
//  habits
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//

import Foundation
import CoreData

protocol ManagedObject {

}

extension ManagedObject where Self : NSManagedObject {

    init(context:NSManagedObjectContext) {
        let name = self.dynamicType.entityName
        let entity = NSEntityDescription.entityForName(name, inManagedObjectContext: context)!
        self.init(entity: entity, insertIntoManagedObjectContext: context)
    }

    static func createInContext(context:NSManagedObjectContext) throws -> Self? {
        var instance:Self? = nil
        context.performBlockAndWait { () -> Void in
            instance = NSEntityDescription.insertNewObjectForEntityForName(self.entityName, inManagedObjectContext: context) as? Self
        }

        return instance
    }

    static func fetchInContext(context:NSManagedObjectContext, predicate:NSPredicate? = nil, sortDescriptor:[NSSortDescriptor]? = nil) throws -> [Self]  {
        var instances:[Self]? = nil
        let request = self.fetchRequest(predicate, sortDescriptors: sortDescriptor)
        instances = try context.fetch(request)

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


    static var entityName:String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last! as String
    }
}

extension NSManagedObjectContext {

    func fetch<T where T : NSManagedObject>(request : NSFetchRequest) throws -> [T] {
        let instances = try self.executeFetchRequest(request)
        return (instances as? [T])!
    }
}

extension NSManagedObject : ManagedObject {

}