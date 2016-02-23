//
//  CoreData.swift
//  WXKit
//
//  Created by Charlie Wu on 23/02/2016.
//  Copyright © 2016 Charlie Wu. All rights reserved.
//


import Foundation
import CoreData

protocol ManageObjectContext {

}

extension ManageObjectContext where Self : NSManagedObjectContext {

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

    static func createWithModel(modelName:String,
        storeName:String = "Database.sqlite",
        mergePolicy:NSMergePolicyType = .MergeByPropertyObjectTrumpMergePolicyType,
        options:[NSObject : AnyObject]? = [NSMigratePersistentStoresAutomaticallyOption:1, NSInferMappingModelAutomaticallyOption:1]) -> Self? {

            let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!.URLByAppendingPathComponent(storeName)
            return self.create(atUrl: url, modelName: modelName, mergePolicy: mergePolicy, options: options)
    }

    static func createPirvateAndMainContextWithModel(modelName:String,
        storeName:String = "Database.sqlite",
        mergePolicy:NSMergePolicyType = .MergeByPropertyObjectTrumpMergePolicyType,
        options:[NSObject : AnyObject]? = [NSMigratePersistentStoresAutomaticallyOption:1, NSInferMappingModelAutomaticallyOption:1]) -> (mainContext:Self?, privateContext:Self?, mainContextObserver:NSObjectProtocol?, privateContextObserver:NSObjectProtocol?)  {

            let url = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!.URLByAppendingPathComponent(storeName)
            let mainContext = self.create(atUrl: url, modelName: modelName, mergePolicy: mergePolicy, options: options)

            if let mainContext = mainContext {
                let privateContext = self.init(concurrencyType: .PrivateQueueConcurrencyType)
                privateContext.persistentStoreCoordinator = mainContext.persistentStoreCoordinator
                privateContext.undoManager = nil

                let notificationCenter = NSNotificationCenter.defaultCenter()

                let privateContextObserver = notificationCenter.addObserverForName(NSManagedObjectContextDidSaveNotification, object: privateContext, queue: nil, usingBlock: { notification -> Void in
                    if let notificationObject = notification.object as? NSObject where notificationObject == mainContext {
                        return
                    }
                    mainContext.performBlock({ () -> Void in
                        mainContext.mergeChangesFromContextDidSaveNotification(notification)
                    })
                })

                let mainContextObserver = notificationCenter.addObserverForName(NSManagedObjectContextDidSaveNotification, object: mainContext, queue: nil, usingBlock: { notification -> Void in
                    if let notificationObject = notification.object as? NSObject where notificationObject == privateContext {
                        return
                    }
                    privateContext.performBlock({ () -> Void in
                        privateContext.mergeChangesFromContextDidSaveNotification(notification)
                    })
                })
                return (mainContext, privateContext, mainContextObserver, privateContextObserver)
            }
            return (nil, nil, nil, nil)
    }

    func fetch<T where T : NSManagedObject>(request : NSFetchRequest) throws -> [T] {
        let instances = try self.executeFetchRequest(request)
        return (instances as? [T])!
    }
}

extension NSManagedObjectContext : ManageObjectContext {

}