#include <mex.h>

void massert(bool condition, const char* msg)
{
    if (!condition)
        mexErrMsgTxt(msg);
}

class ProdSumCalculator
{
private:
    size_t nElem;
    const mxArray *cells;
public:
    ProdSumCalculator::ProdSumCalculator(const mxArray *inCells, size_t inNElem) : nElem(inNElem), cells(inCells) {}

    double ProdSumCalculator::Calculate()
    {
        double sum = 0.0;
        for(size_t ii = 0; ii < nElem; ++ii)
        {
            sum += CellProd(mxGetCell(cells, ii));
        }
        return sum;
    }

    double CellProd(const mxArray *cell)
    {
        massert(mxIsDouble(cell) && !mxIsComplex(cell), "Cells must be real double arrays.");

        double *arr = (double *)mxGetDoubles(cell);
        size_t nArr = mxGetNumberOfElements(cell);

        return Prod(arr, nArr);
    }

    double Prod(double *arr, size_t nArr)
    {
        double prod = *arr++;
        for(size_t jj = 1; jj < nArr; ++jj)
        {
            prod *= *arr++;
        }
        return prod;
    }
};

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    massert(nrhs == 1, "Only 1 input allowed.");
    massert(nlhs < 2, "Only 1 output allowed.");
    
    const mxArray *cells = prhs[0];
    massert(mxIsCell(cells), "Inputs must be cells.");

    size_t nElem = mxGetNumberOfElements(cells);

    ProdSumCalculator calc(cells, nElem);

    plhs[0]         = mxCreateDoubleMatrix(1, 1, mxREAL);
    double *pout    = mxGetPr(plhs[0]);
    *pout           = calc.Calculate();;

    return;
}