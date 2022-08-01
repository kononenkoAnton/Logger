//
//  NotificationManager.swift
//  Logger
//
//  Created by Anton Kononenko on 7/29/22.
//

import Foundation

public extension Notification.Name {
    static let PostLogEvent = Notification.Name("POST_LOG_EVENT")
    static let PostBatchLogEvents = Notification.Name("POST_BATCH_LOG_EVENTS")
    static let PostStorageEvents = Notification.Name("POST_STORAGE_EVENT")
    static let SocketStatusDidUpdate = Notification.Name("SOCKET_STATUS_DID_UPDATE")
}

protocol NotificationObserver: AnyObject {
    func notificationDidReceived(key: NotificationManager.NotificationEvenName, data: Any?)
}

class NotificationManager {
    typealias NotificationEvenName = Notification.Name
    typealias ObserversData = [NotificationEvenName: [NotificationObserver]]
    var observers: ObserversData = [:]

    static let shared = NotificationManager()

    private init() { }

    func postEvent(eventName: NotificationEvenName, data: Any?) {
        let observersForEvent = getObservers(for: eventName)

        DispatchQueue.main.async {
            observersForEvent.forEach { $0.notificationDidReceived(key: eventName, data: data) }
        }
    }

    func addObserver(observer: NotificationObserver,
                     to eventName: NotificationEvenName) {
        var observersForEvent = getObservers(for: eventName)
        if observersForEvent.first(where: { $0 === observer }) == nil {
            observersForEvent.append(observer)
        }

        observers[eventName] = observersForEvent
    }

    func removeObserver(observer: NotificationObserver,
                        from eventName: NotificationEvenName) {
        var observersForEvent = getObservers(for: eventName)
        observersForEvent.removeAll(where: { $0 === observer })
        observers[eventName] = observersForEvent
    }

    func getObservers(for eventName: NotificationEvenName) -> [NotificationObserver] {
        guard let observersForEvent = observers[eventName] else {
            return []
        }

        return observersForEvent
    }
}
