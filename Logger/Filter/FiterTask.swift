//
//  FiterTask.swift
//  Logger
//
//  Created by Anton Kononenko on 9/20/21.
//

import Foundation

protocol FilterCommand {
    var otherFilter: FilterCommand? { get set }
    var filterAction: ([EventModel]) -> [EventModel] { get set }
    func filter(data: [EventModel]) -> [EventModel]
}

struct FilterTask: FilterCommand {
    var otherFilter: FilterCommand?
    var filterAction: (_ data: [EventModel]) -> [EventModel]
    func filter(data: [EventModel]) -> [EventModel] {
        return filterAction(data)
    }
}
