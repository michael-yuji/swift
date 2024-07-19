//===--- CxxSpanBenchmarks.swift ----------------------------------------===//
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

// TODO change name

import TestsUtils
import CxxStdlibPerformance
import CxxStdlib

// TODO change this
let spanSize: UInt32 = 1_000

// TODO change this
public let benchmarks = [
  BenchmarkInfo(
    name: "CxxSpanBenchmarks.first.benchmark",
    runFunction: first_benchmark,
    tags: [.validation, .bridging, .cxxInterop],
    setUpFunction: makeSpanOnce)
]

func makeSpanOnce() {
  // TODO
  var arr = Array<UInt32>(0..<spanSize)
  initSpan(spanSize)
}

@inline(never)
public func first_benchmark(_ n: Int) {
  // TODO
}