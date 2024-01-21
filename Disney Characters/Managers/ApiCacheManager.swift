//
//  ApiCachManager.swift
//  Disney Characters
//
//  Created by Etang on 20/01/2024.
//

import Foundation

/// Manager in memory session scoped API caches
final class ApiCacheManager {
    
    // API URL: Data
    
    private var cacheDictionay: [
        EndPoint: NSCache<NSString, NSData>
    ] = [:]
    
    init() {
        setUpCache()
    }
    
    // MARK - Public
    
    public func cachedResponse(for endpoint: EndPoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionay[endpoint], let url = url else {
            return nil
        }
        let key = url.absoluteString as NSString
        return targetCache.object(forKey: key) as? Data
    }
    
    public func setCache(for endpoint: EndPoint, url: URL?, data: Data) {
        guard let targetCache = cacheDictionay[endpoint], let url = url else {
            return
        }
        let key = url.absoluteString as NSString
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    // MARK - Private
    
    private func setUpCache() {
        EndPoint.allCases.forEach({ endpoint in
            cacheDictionay[endpoint] = NSCache<NSString, NSData>()
        })
    }
    
    
}
