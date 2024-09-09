#ifndef TEST_INTEROP_CXX_STDLIB_INPUTS_STD_ARRAY_H
#define TEST_INTEROP_CXX_STDLIB_INPUTS_STD_ARRAY_H

#include <cstddef>
#include <string>
#include <array>

using Array = std::array<int, 3>;
using ArrayOfString = std::array<std::string, 3>;

static Array iarray = {1, 2, 3};
static ArrayOfString sarray = {"", "ab", "abc"};

inline Array initArray() { 
  return {1, 2, 3};
}

#endif // TEST_INTEROP_CXX_STDLIB_INPUTS_STD_ARRAY_H
