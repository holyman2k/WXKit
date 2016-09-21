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


//extension NSManagedObject {
//    
//    static func fetchRequest(_ predicate:NSPredicate? = nil, sortDescriptors:[NSSortDescriptor]? = nil) -> NSFetchRequest<NSFetchRequestResult> {
//        let request = self.fetchRequest()
//        request.predicate = predicate
//        request.sortDescriptors = sortDescriptors
//        return request
//    }
//    
//    static func createInContext(_ context:NSManagedObjectContext) throws -> Self? {
//        let managedObject = self.init(context: context)
//        return managedObject
//    }
//    
//    static fetchIn
//}


extension ManagedObject where Self : NSManagedObject {

    static func createInContext(_ context:NSManagedObjectContext) throws -> Self? {
        var instance:Self? = nil
        context.performAndWait { () -> Void in
            instance = NSEntityDescription.insertNewObject(forEntityName: self.entityName, into: context) as? Self
        }

        return instance
    }

    static func fetchInContext(_ context:NSManagedObjectContext, predicate:NSPredicate? = nil, sortDescriptor:[NSSortDescriptor]? = nil) throws -> [Self]  {
        var instances:[Self]? = nil
        let request = self.fetchRequest(predicate, sortDescriptors: sortDescriptor)
        instances = try context.fetch(request)

        if let instances = instances {
            return instances
        } else {
            return [Self]()
        }
    }

    static func fetchRequest(_ predicate:NSPredicate? = nil, sortDescriptors:[NSSortDescriptor]? = nil) -> NSFetchRequest<NSFetchRequestResult> {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: self.entityName);
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        return request;
    }

    func deleteInContext(_ context:NSManagedObjectContext) {
        context.delete(self)
    }

    static var entityName:String {
        return NSStringFromClass(object_getClass(self)).components(separatedBy: ".").last! as String
    }

    static func entityNameString() -> String {
        return NSStringFromClass(object_getClass(self)).components(separatedBy: ".").last! as String
    }
}

extension NSManagedObjectContext {

    func fetch<T>(_ request : NSFetchRequest<NSFetchRequestResult>) throws -> [T] where T : NSManagedObject {
        let instances = try self.fetch(request)
        return (instances as? [T])!
    }
}

extension NSManagedObject : ManagedObject {
}
