//
//  PersistenceService.swift
//  Github Users
//
//  Created by Jansen Ducusin on 3/22/21.
//

import UIKit




//class PersistenceService{
//    static let shared = PersistenceService()
//    let container: NSPersistentContainer = {
//        var container = NSPersistentContainer(name: "Github_Users")
//        container.loadPersistentStores { storeDescription, error in
//            // resolve conflict by using correct NSMergePolicy
//            container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
//
//            if let error = error {
//                print("Unresolved error \(error)")
//            }
//        }
//        return container
//    }()
//
//    private func all(withPredicates predicates:[NSPredicate] = [], withRequest request:NSFetchRequest<User>, completion: @escaping((Result<[User], Error>)->())){
//
//        let attributeSortDescriptor = NSSortDescriptor(key: "id", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
//            request.sortDescriptors = [attributeSortDescriptor]
//
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
//        request.predicate = compoundPredicate
//
//        do {
//            let data = try container.viewContext.fetch(request)
//            completion(.success(data))
//
//        } catch {
//            completion(.failure(error))
//            return
//        }
//
//    }
//
//    public func save(completion:@escaping(Error?)->()){
//        if container.viewContext.hasChanges {
//            do{
//                try container.viewContext.save()
//                completion(nil)
//            }catch{
//                completion(error)
//            }
//        }
//    }
//}
//
//extension PersistenceService{
//    public func retrieveUsers(withPagination page:Int, completion:@escaping((Result<[User], Error>)->()))  {
//
//        let predicatePagination = NSPredicate(format: "id > %i", page)
//
//        let requestItem: NSFetchRequest<User> = User.fetchRequest()
//        self.all(withPredicates:[predicatePagination], withRequest: requestItem, completion: completion)
//    }
//}
