@_exported import struct Foundation.URLQueryItem
import struct Foundation.URLComponents

#if os(Linux)
//FIXME: remove that when Foundation will be fixed
//https://bugs.swift.org/browse/SR-384
//URLComponents.queryItems crashes on Linux. This is drop-in replacement.

extension URLComponents {
    public var queryItems: [URLQueryItem]? {
        guard let queryPairs = url?.query?.components(separatedBy: "&") else { return nil }
        
        var items = [URLQueryItem]()
        for nv in queryPairs {
            let pair = nv.components(separatedBy: "=")
            
            let name = pair[0]
            let value: String? = pair.count > 1 ? pair[1] : nil
            
            let item = URLQueryItem(name: name, value: value?.removingPercentEncoding)
            items.append(item)
        }
        
        return items.count > 0 ? items : nil
    }
}
#endif
