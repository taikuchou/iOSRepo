//
//  CoreDataTransform.swift
//  TCM_Herbology
//
//  Created by Tai Kuchou on 2024/1/23.
//

import Foundation
import CoreData

protocol CoreDataTransform {
    associatedtype T
    static func fromNSManagedObject(_ data: NSManagedObject) -> T
}
