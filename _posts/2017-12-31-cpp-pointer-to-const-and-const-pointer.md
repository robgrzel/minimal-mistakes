---
title: "C++: pointer to const vs const pointer"
categories:
  - C++ Pointer Types
tags:
  - Pointers
  - References
  - C++
  - Types
  - Const
  
---

# Code reading:

## We read from left to right, ie.:
 - `const int * a` : variable "a" points to "const" type of "int" (4-bits) data in memory.
 - `int * const b` : variable "b" is const and it points to type of "int" (4-bits) data in memory.
 
 
## What does it actually mean?


### Initialization:

- `const int * a;` - is ok, can be initialized;
- `int * const b;` - not ok, uninitialized "cost b";

### Initialize as "0":

- `const int * a = 0;` - is ok
- `int * const b = 0;` - is ok

### Initialize as "1":

- `const int * a = 1;` - not ok, invalid conversion from 'int' to 'const int';
- `int * const b = 1;` - not ok, invalid conversion from 'int' to 'int *';

### Initialize from "int *" type:

```cpp
  int o = 2;
  int * oPtr = &o;
  
  const int * oPtrC = oPtr; //is ok
  int * const oCPtr = oPtr; //is ok
  
  std::cout << o << std::endl; //2
  std::cout << *oPtr << std::endl; //2
  std::cout << *oPtrC << std::endl; //2
  std::cout << *oCPtr << std::endl; //2
  
  std::cout << oPtr << std::endl; //0x7f03af5ed34c
  std::cout << oPtrC << std::endl; //0x7f03af5ed34c
  std::cout << oCPtr << std::endl; //0x7f03af5ed34c
```

### Initialize from "const int *" type:

```cpp
  const int o = 2;
  const int * oPtr = &o;
  
  const int * oPtrC = oPtr;
  //int * const oCPtr = oPtr; //is not ok
  int * const oCPtr =const_cast<int*>( oPtr);

  std::cout << o << std::endl;
  std::cout << *oPtr << std::endl;
  std::cout << *oPtrC << std::endl;
  std::cout << *oCPtr << std::endl;
  
  std::cout << oPtr << std::endl;
  std::cout << oPtrC << std::endl;
  std::cout << oCPtr << std::endl;
```

### Reinitialize from "int *" type:

```cpp
  const int o = 2;
  const int * oPtr = &o;
  
  const int * oPtrC = oPtr;
  int * const oCPtr =const_cast<int*>( oPtr);

  int a = 1;
  int * aPtr = &a;
  
  oPtrC = aPtr;
  //oCPtr = aPtr; //not ok, assigment of read-only variable OCPtr
  *oCPtr = a;
  
  std::cout << o << std::endl; //1
  std::cout << *oPtr << std::endl; //2
  std::cout << *oPtrC << std::endl;//2
  std::cout << *oCPtr << std::endl;//2
  
  std::cout << oPtr << std::endl;//0x76ce1e238e68
  std::cout << oPtrC << std::endl; //0x76ce1e238e6c
  std::cout << oCPtr << std::endl;//0x76ce1e238e68
```