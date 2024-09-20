## Problem

`std::span` conforms to `CxxRandomAccessCollection`, which has a `subscript` function defined. However, when the C++ subscript function exists, we prefer to call the one from C++.

```c++
const std::span<const int>
const std::span<int>
std::span<const int>
std::span<int>
```

In the second version, the `subscript` from `CxxRandomAccessCollection` gets called instead of the one from C++. In all other cases, the C++ (correct) subscript gets called.
We want to find out why in the specific case of `const std::span<int>` the incorrect function gets called and hopefully fix this. 

## Examples

See `use-std-span-debug.swift` for the incorrect example and `use-std-span-debug-correct.swift` for the correct one. 

## Investigation

> Look for `TODO` for where to put the breakpoints

File `NameLookup.cpp`, function `QualifiedLookupRequest::evaluate` (line 2553): 

Here we see that, in both examples, `DC` contains the same `subscript` function, which means that the choice for the wrong `subscript` happens after this point. 

---

File `TypeCheckProtocol.cpp`, function `WitnessChecker::lookupValueWitnesses` (line 1542):

The call to `DC->lookupQualified` returns multiple decls of `subscript` and we add some of them to `witnesses`

---

File `TypeCheckProtocol.cpp`, function `WitnessChecker::findBestWitness` (line 1542):

`DC`: DeclContext (`std::span` in C++).
If you dump this, you'll see it stores the correct `subscript` function. 

In this function, we `lookupValueWitnesses` for a particular `ValueDecl` (in this case, we want the one for `subscript`).
Then, (line 1595) we filter the witnesses. This is the part that requires more investigation. The bug is probably here in this function. 

