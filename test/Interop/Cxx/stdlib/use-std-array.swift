// RUN: %target-run-simple-swift(-I %S/Inputs -Xfrontend -enable-experimental-cxx-interop -Xcc -std=c++20 -Xcc -D_LIBCPP_HARDENING_MODE=_LIBCPP_HARDENING_MODE_FAST)

// REQUIRES: executable_test

import StdlibUnittest
#if !BRIDGING_HEADER
import StdArray
#endif
import CxxStdlib

var StdArrayTestSuite = TestSuite("StdArray")

func takesArrayOfInt(_ arr: Array) {
  expectEqual(arr.size(), 3)
  expectFalse(arr.empty())

  expectEqual(arr[0], 1)
  expectEqual(arr[1], 2)
  expectEqual(arr[2], 3)
}

func takesArrayOfString(_ arr: ArrayOfString) {
  expectEqual(arr.size(), 3)
  expectFalse(arr.empty())

  expectEqual(arr[0], "")
  expectEqual(arr[1], "ab")
  expectEqual(arr[2], "abc")
}

// func returnsSpanOfInt() -> Span {
//   let arr: [Int32] = [1, 2, 3]
//   return arr.withUnsafeBufferPointer { ubpointer in
//     return Span(ubpointer)
//   }
// }

// func returnsSpanOfInt(_ arr: [Int32]) -> Span {
//   return arr.withUnsafeBufferPointer { ubpointer in
//     return Span(ubpointer)
//   }
// }

// func returnsSpanOfString() -> SpanOfString {
//   let arr: [std.string] = ["", "a", "ab", "abc"]
//   return arr.withUnsafeBufferPointer { ubpointer in
//     return SpanOfString(ubpointer)
//   }
// }

// func returnsSpanOfString(_ arr: [std.string]) -> SpanOfString {
//   return arr.withUnsafeBufferPointer { ubpointer in
//     return SpanOfString(ubpointer)
//   }
// }

StdArrayTestSuite.test("EmptyArray") {
  let arr = Array()
  expectEqual(arr.size(), 3)
  expectFalse(arr.empty())
}

// StdArrayTestSuite.test("Init SpanOfInt") {
//   let s = initSpan()
//   expectEqual(s.size(), 3)
//   expectFalse(s.empty())
// }

StdArrayTestSuite.test("Access static ArrayOfInt") {
  expectEqual(iarray.size(), 3)
  expectFalse(iarray.empty())

  expectEqual(iarray[0], 1)
  expectEqual(iarray[1], 2)
  expectEqual(iarray[2], 3)
  // print(iarray[4])
}

StdArrayTestSuite.test("Access static ArrayOfString") {
  expectEqual(sarray.size(), 3)
  expectFalse(sarray.empty())

  expectEqual(sarray[0], "")
  expectEqual(sarray[1], "ab")
  expectEqual(sarray[2], "abc")
}

StdArrayTestSuite.test("ArrayOfInt as Param") {
  takesArrayOfInt(iarray)
}

StdArrayTestSuite.test("ArrayOfString as Param") {
  takesArrayOfString(sarray)
}

StdArrayTestSuite.test("Change value of ArrayOfInt") {
  var arr = initArray()
  expectEqual(arr[1], 2)
  arr[1] = 10
  expectEqual(arr[1], 10)
}

// StdArrayTestSuite.test("Return SpanOfInt") {
//   let s1 = returnsSpanOfInt()
//   expectEqual(s1.size(), 3)
//   expectFalse(s1.empty())

//   let arr: [Int32] = [4, 5, 6, 7]
//   let s2 = returnsSpanOfInt(arr)
//   expectEqual(s2.size(), 4)
//   expectFalse(s2.empty())

//   expectEqual(s2[0], 4)
//   expectEqual(s2[1], 5)
//   expectEqual(s2[2], 6)
//   expectEqual(s2[3], 7)
// }

// StdArrayTestSuite.test("Return SpanOfString") {
//   let s1 = returnsSpanOfString()
//   expectEqual(s1.size(), 4)
//   expectFalse(s1.empty())

//   let arr: [std.string] = ["", "a", "ab"]
//   let s2 = returnsSpanOfString(arr)
//   expectEqual(s2.size(), 3)
//   expectFalse(s2.empty())

//   expectEqual(s2[0], "")
//   expectEqual(s2[1], "a")
//   expectEqual(s2[2], "ab")
// }

// StdArrayTestSuite.test("SpanOfInt.init(addr, count)") {
//   let arr: [Int32] = [1, 2, 3]
//   arr.withUnsafeBufferPointer { ubpointer in
//     let s = Span(ubpointer.baseAddress!, ubpointer.count)
    
//     expectEqual(s.size(), 3)
//     expectFalse(s.empty())

//     expectEqual(s[0], 1)
//     expectEqual(s[1], 2)
//     expectEqual(s[2], 3)
//   }
// }

// StdArrayTestSuite.test("SpanOfInt.init(ubpointer)") {
//   let arr: [Int32] = [1, 2, 3]
//   arr.withUnsafeBufferPointer { ubpointer in
//     let s = Span(ubpointer)
    
//     expectEqual(s.size(), 3)
//     expectFalse(s.empty())

//     expectEqual(s[0], 1)
//     expectEqual(s[1], 2)
//     expectEqual(s[2], 3)
//   }
// }

// StdArrayTestSuite.test("SpanOfString.init(addr, count)") {
//   let arr: [std.string] = ["", "a", "ab", "abc"]
//   arr.withUnsafeBufferPointer { ubpointer in
//     let s = SpanOfString(ubpointer.baseAddress!, ubpointer.count)
    
//     expectEqual(s.size(), 4)
//     expectFalse(s.empty())

//     expectEqual(s[0], "")
//     expectEqual(s[1], "a")
//     expectEqual(s[2], "ab")
//     expectEqual(s[3], "abc")
//   }
// }

// StdArrayTestSuite.test("SpanOfString.init(ubpointer)") {
//   let arr: [std.string] = ["", "a", "ab", "abc"]
//   arr.withUnsafeBufferPointer { ubpointer in
//     let s = SpanOfString(ubpointer)
    
//     expectEqual(s.size(), 4)
//     expectFalse(s.empty())

//     expectEqual(s[0], "")
//     expectEqual(s[1], "a")
//     expectEqual(s[2], "ab")
//     expectEqual(s[3], "abc")
//   }
// }

// StdArrayTestSuite.test("SpanOfInt for loop") {
//   let arr: [Int32] = [1, 2, 3]
//   arr.withUnsafeBufferPointer { ubpointer in
//     let s = Span(ubpointer)

//     var count: Int32 = 1
//     for e in s {
//       expectEqual(e, count)
//       count += 1
//     }

//     expectEqual(count, 4)
//   }
// }

// StdArrayTestSuite.test("SpanOfString for loop") {
//   let arr: [std.string] = ["", "a", "ab", "abc"]
//   arr.withUnsafeBufferPointer { ubpointer in
//     let s = SpanOfString(ubpointer)
    
//     var count = 0
//     for e in s {
//       count += e.length();
//     }

//     expectEqual(count, 6)
//   }
// }

// StdArrayTestSuite.test("SpanOfInt.map") {
//   let arr: [Int32] = [1, 2, 3]
//   arr.withUnsafeBufferPointer { ubpointer in
//     let s = Span(ubpointer)
//     let result = s.map { $0 + 5 }
//     expectEqual(result, [6, 7, 8])
//   }
// }

// StdArrayTestSuite.test("SpanOfString.map") {
//   let arr: [std.string] = ["", "a", "ab", "abc"]
//   arr.withUnsafeBufferPointer { ubpointer in
//     let s = SpanOfString(ubpointer)
//     let result = s.map { $0.length() }
//     expectEqual(result, [0, 1, 2, 3])
//   }
// }

// StdArrayTestSuite.test("SpanOfInt.filter") {
//   let arr: [Int32] = [1, 2, 3, 4, 5]
//   arr.withUnsafeBufferPointer { ubpointer in
//     let s = Span(ubpointer)
//     let result = s.filter { $0 > 3 }
//     expectEqual(result.count, 2)
//     expectEqual(result, [4, 5])
//   }
// }

// StdArrayTestSuite.test("SpanOfString.filter") {
//   let arr: [std.string] = ["", "a", "ab", "abc"]
//   arr.withUnsafeBufferPointer { ubpointer in
//     let s = SpanOfString(ubpointer)
//     let result = s.filter { $0.length() > 1}
//     expectEqual(result.count, 2)
//     expectEqual(result, ["ab", "abc"])
//   }
// }

// StdArrayTestSuite.test("Initialize Array from SpanOfInt") {
//   let arr: [Int32] = [1, 2, 3]
//   let span: Span = returnsSpanOfInt(arr)
//   let newArr = Array(span)

//   expectEqual(arr.count, newArr.count)
//   expectEqual(arr, newArr)
// }

// StdArrayTestSuite.test("Initialize Array from SpanOfString") {
//   let arr: [std.string] = ["", "a", "ab"]
//   let span: SpanOfString = returnsSpanOfString(arr)
//   let newArr = Array(span)

//   expectEqual(arr.count, newArr.count)
//   expectEqual(arr, newArr)
// }

// StdArrayTestSuite.test("rdar://126570011") {
//   var cp = CppApi()
//   let sp = cp.getSpan()
//   print(sp[0])
//   print(sp[1])
//   // print(sp[3])
// }

runAllTests()
