#include <cuda.h>
#include <cuda_runtime.h>
#include "common.h"
#include "efficient.h"
#include "device_launch_parameters.h"
#define blockSize 128


namespace StreamCompaction {
    namespace Efficient {
        using StreamCompaction::Common::PerformanceTimer;
        PerformanceTimer& timer()
        {
            static PerformanceTimer timer;
            return timer;
        }

        /**
         * Performs prefix-sum (aka scan) on idata, storing the result into odata.
         */
		__global__ void upSweep(int n, int k, int *dev) {
			int index = (blockIdx.x * blockDim.x) + threadIdx.x;
			if (index >= n) return;

			if ((index % (2 * k) == 0) && (index + (2 * k) <= n))
				dev[index + (2 * k) - 1] += dev[index + k - 1];
		}

		__global__ void downSweep(int n, int k, int *idata) {
			int index = (blockIdx.x * blockDim.x) + threadIdx.x;
			if (index >= n) return;
			// need to check boundary
			if ((index % (2 * k) == 0) && (index + (2 * k) <= n)) {
				int temp = idata[index + k - 1];
				idata[index + k - 1] = idata[index + (2 * k) - 1];
				idata[index + (2 * k) - 1] += temp;
			}
		}

        void scan(int n, int *odata, const int *idata) {
			int *exclusive;
			int length = pow(2, ilog2ceil(n));
			cudaMalloc((int**)&exclusive, length * sizeof(int));
			cudaMemset(exclusive, 0, length * sizeof(int));
			cudaMemcpy(exclusive, idata, n * sizeof(int), cudaMemcpyHostToDevice);
			dim3 fullBlocksPerGrid((length + blockSize - 1) / blockSize);
			timer().startGpuTimer();
			// TODO
			// up-sweep
			for (int d = 0; d < ilog2ceil(length); d++) {
				upSweep<<< fullBlocksPerGrid, blockSize >>>(length, pow(2, d), exclusive);
			}
			cudaMemset(exclusive + length - 1, 0, sizeof(int));
			// down-sweep
			for (int d = ilog2ceil(length) - 1; d >= 0; d--) {
				downSweep<<< fullBlocksPerGrid, blockSize >>>(length, pow(2, d), exclusive);
			}
            timer().endGpuTimer();
			cudaMemcpy(odata, exclusive, n * sizeof(int), cudaMemcpyDeviceToHost);
			cudaFree(exclusive);
        }

        /**
         * Performs stream compaction on idata, storing the result into odata.
         * All zeroes are discarded.
         *
         * @param n      The number of elements in idata.
         * @param odata  The array into which to store elements.
         * @param idata  The array of elements to compact.
         * @returns      The number of elements remaining after compaction.
         */
        int compact(int n, int *odata, const int *idata) {
            timer().startGpuTimer();
            // TODO
            timer().endGpuTimer();
            return -1;
        }
    }
}
