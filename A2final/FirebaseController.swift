//
//  FirebaseController.swift
//  A2final
//
//  Created by KoujiMinamoto on 28/9/19.
//  Copyright © 2019 Monash. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore
class FirebaseController: NSObject, DatabaseProtocol {

 var listeners = MulticastDelegate<DatabaseListener>()
 var authController: Auth
 var database: Firestore
 var testRef: CollectionReference?


    var aTest:test
 

 override init() {
 // To use Firebase in our application we first must run the FirebaseApp configure method
 FirebaseApp.configure()
 // We call auth and firestore to get access to these frameworks
 authController = Auth.auth()
 database = Firestore.firestore()
    aTest = test(Red:0,Green:0,Blue:0,preesure:0.0,clear:0,tem:0.0)
 

 super.init()

 // This will START THE PROCESS of signing in with an anonymous account
 // The closure will not execute until its recieved a message back which can be any time later
 authController.signInAnonymously() { (authResult, error) in
 guard authResult != nil else {
 fatalError("Firebase authentication failed")
 }
 // Once we have authenticated we can attach our listeners to the firebase firestore
 self.setUpListeners()
}
 }

 func setUpListeners() {
 testRef = database.collection("A2")
 testRef?.addSnapshotListener { querySnapshot, error in
 guard (querySnapshot?.documents) != nil else {
 print("Error fetching documents: \(error!)")
 return
 }
 self.parseTestsSnapshot(snapshot: querySnapshot!)
 }


 }

 func parseTestsSnapshot(snapshot: QuerySnapshot) {
 snapshot.documentChanges.forEach { change in
 let documentRef = change.document.documentID
 let red = change.document.data()["Red"] as! Int
 let blue = change.document.data()["Blue"] as! Int
 let green = change.document.data()["Green"] as! Int
 let pressure = change.document.data()["Pressure"] as! Double
 let clear = change.document.data()["Clear"] as! Int
 let tem = change.document.data()["Temperature"] as! Double
 print(red)
 print(documentRef)
    if change.type == .modified{
        aTest.Blue = blue
        aTest.Red = red
        aTest.Green = green
        aTest.clear = clear
        aTest.preesure = pressure
        aTest.tem = tem
    }
}

listeners.invoke { (listener) in
if listener.listenerType == ListenerType.all {
    listener.ontestListChange(change: .update, test: [aTest])
}
}
}


//func getHeroIndexByID(reference: String) -> Int? {
//for hero in heroList {
//if(hero.id == reference) {
//return heroList.firstIndex(of: hero)
//}
//}
//
//return nil
//}
//
//func getHeroByID(reference: String) -> SuperHero? {
//for hero in heroList {
//if(hero.id == reference) {
//return hero
//}
//}
//
//return nil
//}




 

 func addListener(listener: DatabaseListener) {
 listeners.addDelegate(listener)


    listener.ontestListChange(change: .update, test: [aTest])

 }

 func removeListener(listener: DatabaseListener) {
 listeners.removeDelegate(listener)
 }
}

