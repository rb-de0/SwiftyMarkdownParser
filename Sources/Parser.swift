import CDiscount
import Foundation

public class Parser{
    
    class func toHtml(markdown: String) -> String{
        let document = mkd_string(markdown, Int32(markdown.lengthOfBytes(using: NSUTF8StringEncoding)), 0)
        
        defer{
            mkd_cleanup(document)
        }
        
        mkd_compile(document, 0)
        
        var output = [UnsafeMutablePointer<Int8>?](repeating: UnsafeMutablePointer<Int8>(allocatingCapacity: 1), count: 1)
        mkd_document(document, &output)
        
        if output.isEmpty{
            return ""
        }
        
        guard let html = output[0] else{
            return ""
        }
        
        let result = String(cString: html)
        return result
    }
    
}
