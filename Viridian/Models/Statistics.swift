//
//  Statistics.swift
//  Vridian
//
//  Created by Eleanor on 2/24/19.
//

import Foundation
import CoreData
import UIKit

class Statistics {
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var moc: NSManagedObjectContext!
    let persistentContainer = NSPersistentContainer(name: "Vridian")
    var entries: [Diary] = []
    
    static var dataHasChanged: Bool = true
    
    func calculateTable() -> [String] {
        
        retrieve()
        
        let emissions = entries.reduce(0) {(result, entry) -> Float in
            return result + ( (Float(entry.pts)) / 10000 )
        } //0
        
        let energy = entries.reduce(0.0) {(result, entry) -> Float in
            return result + entry.kWh
        } //1
        
        let fuel = entries.reduce(0.0) {(result, entry) -> Float in
            return result + (entry.mi / 24.7)
        } //2
        
        let miles = entries.reduce(0.0) {(result, entry) -> Float in
            return result + entry.mi
        } // 3
        
        let publicTransport = entries.filter( {$0.actID == 29}).reduce(0.0) {(result, entry) -> Float in
            return result + entry.mi
        } // 4
        
        let onFoot = entries.filter( {$0.actID == 28}).reduce(0.0) {(result, entry) -> Float in
            return result + entry.mi
        } // 5
        
        let compost = entries.filter( {$0.actID == 12}).reduce(0) {(result, entry) -> Int in
            return result + 1
        } // 6
        
        let totalRecycled = entries.filter( {$0.catID == 3}).reduce(0) {(result, entry) -> Int in
            return result + 1
        } // 7
        
        let cansRecycled = entries.filter( {$0.actID == 16}).reduce(0) {(result, entry) -> Int in
            return result + 1
        } // 8
        
        let paperRecycled = entries.filter( {$0.actID == 18}).reduce(0) {(result, entry) -> Int in
            return result + 1
        }
        
        let plasticRecycled = entries.filter( {($0.actID == 21) || ($0.actID == 22)} ).reduce(0) {(result, entry) -> Int in
            return result + 1
        }
        
        let glassRecycled = entries.filter( {($0.actID == 20)} ).reduce(0) {(result, entry) -> Int in
            return result + 1
        }
        
        let batteriesRecycled = entries.filter( {($0.actID == 15) || ($0.actID == 17)} ).reduce(0) {(result, entry) -> Int in
            return result + 1
        }
        
        let allOtherRecycling = entries.filter( {($0.catID == 3) && !(($0.actID == 16) || ($0.actID == 18) || ($0.actID == 21) || ($0.actID == 22) || ($0.actID == 20) || ($0.actID == 15) || ($0.actID == 17))}).reduce(0) {(result, entry) -> Int in
            return result + 1
        }
        
        let totalPaper = entries.reduce(0.0) {(result, entry) -> Float in
            return result + (Float(entry.paper) * 0.01)
        }
        
        let totalPlastic = entries.reduce(0) {(result, entry) -> Float in
            return result + (Float(entry.plastic) / 454)
        }
        
        let bottleLbs = entries.filter( {($0.actID == 13)}).reduce(0) {(result, entry) -> Float in
            return result + (Float(entry.plastic) / 454)
        }
        
        let bagLbs = entries.filter( {($0.actID == 11) || ($0.actID == 21) || ($0.actID == 25)}).reduce(0) {(result, entry) -> Float in
            return result + (Float(entry.plastic) / 454)
        }
        
        let water = entries.reduce(0) {(result, entry) -> Float in
            return result + entry.water
        }
        
        let meatlessMeals = entries.filter( {($0.actID == 3) || ($0.actID == 4)}).reduce(0) {(result, entry) -> Int in
            return result + 1
        }
        
        let leftovers = entries.filter({$0.actID == 5}).reduce(0){(result, entry) -> Int in
            return result + 1
        }
        
        return [String( (emissions * 10).rounded() / 10), String( (energy * 10).rounded() / 10), String( (fuel * 10).rounded() / 10), String( (miles * 10).rounded() / 10), String( (publicTransport * 10).rounded() / 10), String( (onFoot * 10).rounded() / 10), String(compost), String(totalRecycled), String(cansRecycled), String(paperRecycled), String(plasticRecycled), String(glassRecycled), String(batteriesRecycled), String(allOtherRecycling), String( (totalPaper * 10).rounded() / 10), String( (totalPlastic * 10).rounded() / 10), String( (bottleLbs * 10).rounded() / 10), String( (bagLbs * 10).rounded() / 10), String( (water * 10).rounded() / 10), String(meatlessMeals), String(leftovers)]
    }
}
