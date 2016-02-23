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

protocol SwfitManagedObject {

    static var entityName:String {get}
}

protocol SwiftManageObjectContext {
    func fetch<T where T : NSManagedObject>(request : NSFetchRequest) -> [T]
}

// MARK: protocol extensions

extension SwiftManageObjectContext where Self : NSManagedObjectContext {

    static func create(atUrl url:NSURL?, modelName:String, mergePolicy:NSMergePolicyType, options:[NSObject : AnyObject]?) -> Self? {

        let storeType = url != nil ? NSSQLiteStoreType : NSInMemoryStoreType

        if let modelUrl = NSBundle.mainBundle().URLForResource(modelName, withExtension: "momd"),
            let managedObjectModel = NSManagedObjectModel(contentsOfURL: modelUrl) {
                let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
                do {
                    try persistentStoreCoordinator.addPersistentStoreWithType(storeType, configuration: nil, URL: url, options: options)
                } catch   {
                    abort()
                }

                let mergePolicy = NSMergePolicy(mergeType:  mergePolicy)
                let context = Self(concurrencyType: .MainQueueConcurrencyType)
                context.persistentStoreCoordinator = persistentStoreCoordinator
                context.mergePolicy = mergePolicy
                return context
        }
        return nil
    }

    func fetch<T where T : NSManagedObject>(request : NSFetchRequest) -> [T] {
        let instances = try! self.executeFetchRequest(request)
        return (instances as? [T])!
    }
}

extension SwfitManagedObject where Self : NSManagedObject {

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

extension NSManagedObjectContext : SwiftManageObjectContext {

    static func createWithModel(modelName:String,
        storeName:String = "Database.sqlite",
        mergePolicy:NSMergePolicyType = .MergeByPropertyObjectTrumpMergePolicyType,
        options:[NSObject : AnyObject]? = [NSMigratePersistentStoresAutomaticallyOption:1, NSInferMappingModelAutomaticallyOption:1]) -> NSManagedObjectContext? {

        let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!.URLByAppendingPathComponent(storeName)
        return self.create(atUrl: url, modelName: modelName, mergePolicy: mergePolicy, options: options)
    }
}

extension NSManagedObject : SwfitManagedObject {
    static var entityName:String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last! as String
    }
}
