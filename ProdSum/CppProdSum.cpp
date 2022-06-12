#include <mex.hpp>
#include <mexAdapter.hpp>

matlab::data::ArrayFactory factory;

class MexFunction : public matlab::mex::Function 
{
private: 
    void massert(bool condition, const char *errMessage)
    {
        if (!condition)
            getEngine()->feval(u"error", 0, std::vector<matlab::data::Array>({ factory.createScalar(std::string(errMessage)) }));
    }
public:
    void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) 
    {
        massert(inputs.size() == 1, "Only 1 input allowed.");
        massert(outputs.size() < 2, "Only 1 output allowed.");
        massert(inputs[0].getType() == matlab::data::ArrayType::CELL, "Input must be a cell array.");

        const matlab::data::CellArray cells = std::move(inputs[0]);
        size_t nElem = cells.getNumberOfElements();

        double sum = 0.0;
        for(size_t ii = 0; ii < nElem; ++ii)
        {
            sum += CellProd(cells[ii]);
        }
        
        outputs[0] = factory.createScalar(sum);
    }

    double CellProd(const matlab::data::Array cell)
    {
        massert(cell.getType() == matlab::data::ArrayType::DOUBLE, "Cells must be real double arrays.");

        const matlab::data::TypedArray<double> tarr = cell;
        const double *arr   = tarr.begin().operator->();
        size_t nVals        = tarr.getNumberOfElements();

        double prod = *arr++;
        for(size_t jj = 1; jj < nVals; ++jj)
        {
            prod *= *arr++;
        }

        return prod;
    }
};