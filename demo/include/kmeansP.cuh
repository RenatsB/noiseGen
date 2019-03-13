#include <cuda_runtime.h>
#include "ImageGenFn.hpp" //this includes generator, random and utilTypes

// for devices of compute capability 2.0 and higher
#if defined(__CUDA_ARCH__) && (__CUDA_ARCH__ < 200)
   #define printf(f, ...) ((void)(f, __VA_ARGS__),0)
#endif

// For thrust routines (e.g. stl-like operators and algorithms on vectors)
#include <vector>
#include <thrust/host_vector.h>
#include <thrust/device_vector.h>

__device__ float sq_Parallel(float ref);

__device__ float sq_Col_l2_Dist_Parallel(float4 first, float4 second);

//const float4* __restrict__ data this is waaaaaaay faster
__global__ void assign_clusters(thrust::device_ptr<float4> data,
                                size_t data_size,
                                const thrust::device_ptr<float4> means,
                                thrust::device_ptr<float4> new_sums,
                                size_t k,
                                thrust::device_ptr<int> counts,
                                thrust::device_ptr<int> h_assign);

__global__ void compute_new_means(thrust::device_ptr<float4> means,
                                const thrust::device_ptr<float4> new_sum,
                                const thrust::device_ptr<int> counts);

__global__ void write_new_mean_colors(thrust::device_ptr<float4> means,
                                      size_t data_size,
                                      thrust::device_ptr<int> assignment,
                                      thrust::device_ptr<float4> newOut);
std::vector<float> kmeansP(const DataFrame &source,
                           size_t k,
                           size_t number_of_iterations,
                          RandomFn<float>* rfunc);