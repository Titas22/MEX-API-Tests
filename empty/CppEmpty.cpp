#include <mex.hpp>
#include <mexAdapter.hpp>

class MexFunction : public matlab::mex::Function 
{
public:
    void operator()(matlab::mex::ArgumentList outputs, matlab::mex::ArgumentList inputs) 
    {
        matlab::data::ArrayFactory factory;
        outputs[0] = factory.createEmptyArray();
    }
};