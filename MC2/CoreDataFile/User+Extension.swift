//
//  User+Extension.swift
//  MC2
//
//  Created by Vincent Alexander Christian on 20/05/20.
//  Copyright © 2020 Vincent Alexander Christian. All rights reserved.
//

import Foundation
import CoreData

extension User {
    static func saveUserData(viewContext: NSManagedObjectContext, userName: String, avatar: String, exp: Int16, coin: Int16) -> User? {
        let user = User(context: viewContext)
        user.userName = userName
        user.avatar = avatar
        user.coin = coin
        user.exp = exp
        do{
            try viewContext.save()
            return user
        }
        catch {
            return nil
        }
    }
    
    static func fetchAll(viewContext: NSManagedObjectContext) -> [User]{ //1, view context karna mau akses databse
        let request: NSFetchRequest<User> = User.fetchRequest() //2, declare request data dari model
        guard let result = try? viewContext.fetch(request) else { //eksekusi rquestnya
            return []
        }
        return result
    }
    
    static func updateUserName(viewContext: NSManagedObjectContext, userName: String){
        let user = fetchAll(viewContext: viewContext)
        
        let update = user[0]
        update.setValue(userName, forKey: "userName")
        
        do{
            try viewContext.save()
        }
        catch {
            
        }
    }
    
    static func updateUserExp(viewContext: NSManagedObjectContext, exp: Int16){
        let user = fetchAll(viewContext: viewContext)
        let update = user[0]
        let oldExp = update.exp
        
        print(oldExp)
        print(exp)
        print(exp + oldExp)
        
        update.setValue(exp + oldExp, forKey: "exp")
        
        do{
            try viewContext.save()
        }
        catch {
            
        }
    }
    
    static func updateUserCoin(viewContext: NSManagedObjectContext, coin: Int16){
        let user = fetchAll(viewContext: viewContext)
        let update = user[0]
        let oldCoin = update.coin
        
        print(oldCoin)
        print(coin)
        print(coin + oldCoin)
        
        update.setValue(coin + oldCoin, forKey: "coin")
        
        do{
            try viewContext.save()
        }
        catch {
            
        }
    }
    
    static func deleteAll (viewContext: NSManagedObjectContext) {
        let request : NSFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        let _ = try? viewContext.execute(deleteRequest)
    }
}
