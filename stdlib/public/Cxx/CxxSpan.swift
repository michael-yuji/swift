//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//
import Builtin

public func unsafeBitCast<T: ~Escapable, U>(
   _ x: T, to type: U.Type
) -> U {
  Builtin.reinterpretCast(x)
}

/// A C++ type that is an object that can refer to a contiguous sequence of objects.
///
/// C++ standard library type `std::span` conforms to this protocol.
public protocol CxxSpan<Element> {
  associatedtype Element
  associatedtype Size: BinaryInteger

  init()
  init(_ unsafePointer : UnsafePointer<Element>, _ count: Size)

  func size() -> Size
  func __dataUnsafe() -> UnsafePointer<Element>?
}

extension CxxSpan {
  /// Creates a C++ span from a Swift UnsafeBufferPointer
  @inlinable
  public init(_ unsafeBufferPointer: UnsafeBufferPointer<Element>) {
    precondition(unsafeBufferPointer.baseAddress != nil, 
                  "UnsafeBufferPointer should not point to nil")
    self.init(unsafeBufferPointer.baseAddress!, Size(unsafeBufferPointer.count))
  }

  @inlinable
  public init(_ unsafeMutableBufferPointer: UnsafeMutableBufferPointer<Element>) {
    precondition(unsafeMutableBufferPointer.baseAddress != nil, 
                  "UnsafeMutableBufferPointer should not point to nil")
    self.init(unsafeMutableBufferPointer.baseAddress!, Size(unsafeMutableBufferPointer.count))
  }

  @available(SwiftStdlib 6.1, *)
  @inlinable
  @unsafe
  public init(_ span: Span<Element>) {
    let (p, c) = unsafeBitCast(span, to: (UnsafeRawPointer?, Int).self)
    precondition(p != nil, "Span should not point to nil")
    let binding = p!.bindMemory(to: Element.self, capacity: c)
    self.init(binding, Size(c))
  }
}

@_disallowFeatureSuppression(NonescapableTypes)
@available(SwiftStdlib 6.1, *)
extension Span {
  @_alwaysEmitIntoClient
  @lifetime(immortal)
  @unsafe
  public init<T: CxxSpan<Element>>(
    _unsafeCxxSpan span: T,
  ) {
    self.init(_unsafeElements: .init(start: span.__dataUnsafe(), count: Int(span.size())))
  }
}

public protocol CxxMutableSpan<Element> {
  associatedtype Element
  associatedtype Size: BinaryInteger

  init()
  init(_ unsafeMutablePointer : UnsafeMutablePointer<Element>, _ count: Size)
}

extension CxxMutableSpan {
  /// Creates a C++ span from a Swift UnsafeMutableBufferPointer
  @inlinable
  public init(_ unsafeMutableBufferPointer: UnsafeMutableBufferPointer<Element>) {
    precondition(unsafeMutableBufferPointer.baseAddress != nil, 
                  "UnsafeMutableBufferPointer should not point to nil")
    self.init(unsafeMutableBufferPointer.baseAddress!, Size(unsafeMutableBufferPointer.count))
  }
}
