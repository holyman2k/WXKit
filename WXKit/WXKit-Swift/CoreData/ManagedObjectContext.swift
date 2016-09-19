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

    static func create(atUrl url:URL?, modelName:String, mergePolicy:NSMergePolicyType, options:[AnyHashable: Any]?) -> Self? {

        let storeType = url != nil ? NSSQLiteStoreType : NSInMemoryStoreType

        if let modelUrl = Bundle.main.url(forResource: modelName, withExtension: "momd"),
            let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl) {
                let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
                do {
                    try persistentStoreCoordinator.addPersistentStore(ofType: storeType, configurationName: nil, at: url, options: options)
                } catch   {
                    abort()
                }

                let mergePolicy = NSMergePolicy(merge:  mergePolicy)
                let context = Self(concurrencyType: .mainQueueConcurrencyType)
                context.persistentStoreCoordinator = persistentStoreCoordinator
                context.mergePolicy = mergePolicy
                return context
        }
        return nil
    }

    static func createWithModel(_ modelName:String,
        storeName:String = "Database.sqlite",
        mergePolicy:NSMergePolicyType = .mergeByPropertyObjectTrumpMergePolicyType,
        options:[AnyHashable: Any]? = [NSMigratePersistentStoresAutomaticallyOption:1, NSInferMappingModelAutomaticallyOption:1]) -> Self? {

            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent(storeName)
            return self.create(atUrl: url, modelName: modelName, mergePolicy: mergePolicy, options: options)
    }

    static func createPirvateAndMainContextWithModel(_ modelName:String,
        storeName:String = "Database.sqlite",
        mergePolicy:NSMergePolicyType = .mergeByPropertyObjectTrumpMergePolicyType,
        options:[AnyHashable: Any]? = [NSMigratePersistentStoresAutomaticallyOption:1, NSInferMappingModelAutomaticallyOption:1]) -> (mainContext:Self?, privateContext:Self?, mainContextObserver:NSObjectProtocol?, privateContextObserver:NSObjectProtocol?)  {

            let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last!.appendingPathComponent(storeName)
            let mainContext = self.create(atUrl: url, modelName: modelName, mergePolicy: mergePolicy, options: options)

            if let mainContext = mainContext {
                let privateContext = self.init(concurrencyType: .privateQueueConcurrencyType)
                privateContext.persistentStoreCoordinator = mainContext.persistentStoreCoordinator
                privateContext.undoManager = nil

                let notificationCenter = NotificationCenter.default

                let privateContextObserver = notificationCenter.addObserver(forName: NSNotification.Name.NSManagedObjectContextDidSave, object: privateContext, queue: nil, using: { notification -> Void in
                    if let notificationObject = notification.object as? NSObject , notificationObject == mainContext {
                        return
                    }
                    mainContext.perform({ () -> Void in
                        mainContext.mergeChanges(fromContextDidSave: notification)
                    })
                })

                let mainContextObserver = notificationCenter.addObserver(forName: NSNotification.Name.NSManagedObjectContextDidSave, object: mainContext, queue: nil, using: { notification -> Void in
                    if let notificationObject = notification.object as? NSObject , notificationObject == privateContext {
                        return
                    }
                    privateContext.perform({ () -> Void in
                        privateContext.mergeChanges(fromContextDidSave: notification)
                    })
                })
                return (mainContext, privateContext, mainContextObserver, privateContextObserver)
            }
            return (nil, nil, nil, nil)
    }
}

extension NSManagedObjectContext : ManageObjectContext {

}
