//
//  DatabaseProtocol.swift
//  A2final
//
//  Created by KoujiMinamoto on 28/9/19.
//  Copyright © 2019 Monash. All rights reserved.
//

import Foundation
enum DatabaseChange {
 case add
 case remove
 case update
}
enum ListenerType {
 case team
 case heroes
 case all
}
protocol DatabaseListener: AnyObject {
 var listenerType: ListenerType {get set}
 
 func ontestListChange(change: DatabaseChange, test: [test])
}
protocol DatabaseProtocol: AnyObject {
// var defaultTeam: Team {get}

// func addSuperHero(name: String, abilities: String) -> SuperHero
// func addTeam(teamName: String) -> Team
// func addHeroToTeam(hero: SuperHero, team: Team) -> Bool
// func deleteSuperHero(hero: SuperHero)
// func deleteTeam(team: Team)
// func removeHeroFromTeam(hero: SuperHero, team: Team)
 func addListener(listener: DatabaseListener)
 func removeListener(listener: DatabaseListener)
}
