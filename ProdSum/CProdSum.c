#include "mex.h"

void massert(bool condition, const char* msg)
{
    if (!condition)
        mexErrMsgTxt(msg);
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    massert(nrhs == 1, "Only 1 input allowed.");
    massert(nlhs < 2, "Only 1 output allowed.");
    
    const mxArray *cells = prhs[0];
    massert(mxIsCell(cells), "Inputs must be cells.");

    size_t nElem = mxGetNumberOfElements(cells);

    double sum = 0.0;
    for(size_t ii = 0; ii < nElem; ++ii)
    {
        const mxArray *cell = mxGetCell(cells, ii);
        massert(mxIsDouble(cell) && !mxIsComplex(cell), "Cells must be real double arrays.");

        double *arr = (double *)mxGetDoubles(cell);
        size_t nArr = mxGetNumberOfElements(cell);

        double prod = 1.0;
        for(size_t jj = 0; jj < nArr; ++jj)
        {
            prod *= arr[jj];
        }

        sum += prod;
    }

    plhs[0]         = mxCreateDoubleMatrix(1, 1, mxREAL);
    double *pout    = mxGetPr(plhs[0]);
    *pout           = sum;

    return;
}