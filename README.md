# MEX-API-Tests
Matlab MEX API Tests comparing old C and new C++ APIs with the new C++ Data API being significantly slower.<br>
<br>
Matlab Central question: [Is C++ MEX API significantly slower than the C MEX API?](https://uk.mathworks.com/matlabcentral/answers/1735090-is-c-mex-api-significantly-slower-than-the-c-mex-api)

# Example outputs

### nop() - functions that do absolutely nothing
```Matlab
  nothing x100000   |    23.9487ms   |   0.2395us/call   |    1.000x
    nop() x100000   |    31.8879ms   |   0.3189us/call   |    1.332x
   Cnop() x100000   |    77.2739ms   |   0.7727us/call   |    3.227x    - C API & C Compiler
 Cppnop() x100000   |   607.6918ms   |   6.0769us/call   |   25.375x    - C++ API & C++ Compiler
Cppnop2() x100000   |    85.2547ms   |   0.8525us/call   |    3.560x    - C API & C++ Compiler
```

### empty() - functions that return empty result ([])
```Matlab
     inline x100000   |     24.1816ms   |   0.2418us/call   |    1.000x
    empty() x100000   |     29.1480ms   |   0.2915us/call   |    1.205x
      @()[] x100000   |     33.1176ms   |   0.3312us/call   |    1.370x
   CEmpty() x100000   |    116.2378ms   |   1.1624us/call   |    4.807x    - C API & C Compiler
 CppEmpty() x100000   |    784.0485ms   |   7.8405us/call   |   32.423x    - C++ API & C++ Compiler
CppEmpty2() x100000   |    120.9537ms   |   1.2095us/call   |    5.002x    - C API & C++ Compiler
```

### ProdSum() - functions that calculate product of all values in each cell and computes a sum
```Matlab
    ProdSum() x100   |      9.0598ms   |     90.5980us/call   |    1.000x   |   val = 931.56
      cellfun x100   |    197.1907ms   |   1971.9070us/call   |   21.765x   |   val = 931.56
   CProdSum() x100   |      3.8130ms   |     38.1300us/call   |    0.421x   |   val = 931.56    - C API & C Compiler
 CppProdSum() x100   |    147.2003ms   |   1472.0030us/call   |   16.248x   |   val = 931.56    - C++ API & C++ Compiler
CppProdSum2() x100   |      3.6594ms   |     36.5940us/call   |    0.404x   |   val = 931.56    - C API & C++ Compiler
```
