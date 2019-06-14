import UIKit
import Compression


let count = 2
let stride = MemoryLayout<Int>.stride
let alignment = MemoryLayout<Int>.alignment
let byteCount = stride * count

do{
    
    print("Raw pointers")
    
    let pointer = UnsafeMutableRawPointer.allocate(byteCount: byteCount, alignment: alignment)
    
    defer {
        pointer.deallocate()
    }
    
    pointer.storeBytes(of: 100, as: Int.self)
    pointer.advanced(by: stride).storeBytes(of: 6, as: Int.self)
    pointer.load(as: Int.self)
    pointer.advanced(by: stride).load(as: Int.self)
    
    let bufferPointer = UnsafeRawBufferPointer(start: pointer, count: byteCount)
    for (index,byte) in bufferPointer.enumerated() {
        print("byte \(index): \(byte)")
    }
}

do {
    print("Typed pointers")
    
    let pointer = UnsafeMutablePointer<Int>.allocate(capacity: count)
    pointer.initialize(repeating: 0, count: count)
    defer {
        pointer.deinitialize(count: count)
        pointer.deallocate()
    }
    
    pointer.pointee = 42
    pointer.advanced(by: 1).pointee = 6
    pointer.pointee
    pointer.advanced(by: 1).pointee
    
    let bufferPointer = UnsafeBufferPointer(start: pointer, count: count)
    for (index, value) in bufferPointer.enumerated() {
        print("value \(index): \(value)")
    }
}

enum CompressionAlgorithm{
    case lz4
    case lz4a
    case zlib
    case lzfse
}

enum CompressionOperation{
    case compression, decompression
}

struct Compressed{
    let data: Data
    let algorithm: CompressionAlgorithm
    
    
    static func Compress(input: Data, with algorithm: CompressionAlgorithm) -> Compressed?{
        
        guard let data = perform(.compression, on: input, using: algorithm) else {
            return nil
        }
        return Compressed(data: data, algorithm: algorithm)
    }
    
    func decompressed() -> Data? {
        
        return perform(.decompression, on: data, using: algorithm)
    }
}

func perform(_ operation: CompressionOperation, on input: Data, using algorithm: CompressionAlgorithm,workingBufferSize: Int = 2000) -> Data? {
    
    let  streamAlgorithm: compression_algorithm
    
    switch algorithm {
    case .lz4:
        streamAlgorithm = COMPRESSION_LZ4
    case .lz4a:
        streamAlgorithm = COMPRESSION_LZMA
    case .zlib:
        streamAlgorithm = COMPRESSION_ZLIB
    case .lzfse:
        streamAlgorithm = COMPRESSION_LZFSE
    
    }
    
    let streamOperation:compression_stream_operation
    let flags: Int32
    switch operation{
        
    case .compression:
        streamOperation = COMPRESSION_STREAM_ENCODE
        flags = Int32(COMPRESSION_STREAM_FINALIZE.rawValue)
    case .decompression:
        streamOperation = COMPRESSION_STREAM_DECODE
        flags = 0
    }
    
    var streamPointer = UnsafeMutablePointer<compression_stream>.allocate(capacity: 1)
    defer {
        streamPointer.deallocate()
    }
    
    
    var stream = streamPointer.pointee
    var status = compression_stream_init(&stream, streamOperation, streamAlgorithm)
    guard status != COMPRESSION_STATUS_ERROR else {
        return nil
    }
    defer {
        compression_stream_destroy(&stream)
    }
    
    let dstSize = workingBufferSize
    let dstPointer = UnsafeMutablePointer<UInt8>.allocate(capacity: dstSize)
    defer {
        dstPointer.deallocate()
    }
    return input.withUnsafeBytes({ (scrPointer: UnsafePointer<UInt8>)  in
    
        var output = Data()
        stream.src_ptr = scrPointer
        stream.src_size = input.count
        stream.dst_ptr = dstPointer
        stream.dst_size = dstSize
        
        while status == COMPRESSION_STATUS_OK{
            
            status = compression_stream_process(&stream, flags)
            
            switch status {
            case COMPRESSION_STATUS_OK:
                output.append(dstPointer, count: dstSize)
                stream.dst_ptr = dstPointer
                stream.dst_size = dstSize
            case COMPRESSION_STATUS_ERROR:
                return nil
            case COMPRESSION_STATUS_END:
                output.append(dstPointer, count: stream.dst_ptr - dstPointer)
            default:
                fatalError()
            }
        }
        
        return output
    })
    
    
}


extension Data {
    
    func compressed(with algorithm: CompressionAlgorithm) -> Compressed? {
        
        return Compressed.Compress(input: self, with: algorithm)
    }
}
