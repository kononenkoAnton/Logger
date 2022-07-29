//
//  FilteredDataProtocol.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation

protocol FilteredDataProtocol: AnyObject {
    var searchBarFilterData: String? { get set }
}
