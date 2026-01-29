# Configuración de ejecución de kernels CUDA

Cada kernel de CUDA debe ser lanzado usando la siguiente notación:

```C++
 myKernel<<<dGrid, dBlock>>>(args);
```

Los atributos *dGrid* y *dBlock* representan  la dimensión y el tamaño de la malla de bloques a procesar, y el tamaño y la dimensión de cada bloque.

Cada uno de ellos es un objeto de tipo ***dim3***, cuyos componentes x, y e z definen su configuración en tres dimensiones. El defecto de cada dimensión es 1.

Para conocer los límites de cada uno de estos parámetros, se puede hacer uso de la función ***cudaGetDeviceProperties***. La propiedad *maxThreadsDim* permite conocer el límite en cada una de las dimensiones de ***dBlock***, y la propiedad *maxGridSize*  permite conocer el límite de cada una de las dimensiones de ***dGrid***.

Nota: Tenga que cuenta que la cantidad de hilos dentro de  un bloque (obtenido al multiplicar  dBlock.x,  dBlock.y,  dBlock.z) no puede superar el valor de la propiedad *maxThreadsPerBlock*, que en la mayoría de dispositivos está limitada a 1024.

Considere el siguiente dispositivo de ejemplo:

```txt
Device 0: NVIDIA GeForce RTX 3070 Laptop GPU
  Global memory available: 8589410304 bytes
  Compute capability (major.minor): 8.6
  Warp size: 32
  Max size of each dimension of a block (blockDim.x, blockDim.y, blockDim.z): 1024,1024,64
  Max threads per block on all dimensions (blockDim.x * blockDim.y * blockDim.z): 1024
  Max size of each dimension of a grid (gridDim.x, gridDim.y, gridDim.z): 2147483647,65535,65535
```

## Configuración en 2 dimensiones

```C++

// Calling the kernel from host code
// rows,columns: Dimension of the 2D array

// Launch the CUDA Kernel
// threadsPerBlockX * threadsPerBlockY <= 1024
// (1024, 1), (512, 2)
// In this case, z component on both dimensions is 1
dim3 dBlock(threadsPerBlockX, threadsPerBlockY);
dim3 dGrid((columns + dBlock.x - 1) / dBlock.x, (rows + dBlock.y - 1) / dBlock.y);

myKernel<<<dGrid, dBlock>>>(args);

// 2D addressing ( inside kernel thread code)
// d_rows, d_columns: Rows and columns of the original data

// Get this thread column mapping to the original 2-d array
// block index (x) * block dimension (x)  + this thread x offset
int column = (int)blockIdx.x * blockDim.x + threadIdx.x;

// Get this thread row mapping to the original 2-d array
// block index (y) * block dimension (y)  + this thread y offset
int row = (int)blockIdx.y * blockDim.y + threadIdx.y;

// Calculate this thread index (offset) on the flattened array
int index = row * d_columns + column;

if (index < d_rows * d_columns) {
   // ... This thread index is inside data range, perform processing.
}

```

## Configuración en 3 dimensiones

```C++

// Calling the kernel from host code
// rows,columns,depth: Dimension of the 3D array. Depth = number of 2D grids (rows x columns) to process.

// Launch the CUDA Kernel
// threadsPerBlockX * threadsPerBlockY * threadsPerBlockZ <= 1024
// (1024, 1, 1), (512, 2, 1), (256, 2, 2), ... (1, 1, 1024)
dim3 dBlock(threadsPerBlockX, threadsPerBlockY, threadsPerBlockZ);
dim3 dGrid((columns + dBlock.x - 1) / dBlock.x, (rows + dBlock.y - 1) / dBlock.y, (depth + dBlock.z - 1) / dBlock.z);

myKernel<<<dGrid, dBlock>>>(args);

// 3D addressing inside kernel thread code
// Get this thread linear mapping to the original 2-d array
// d_rows, d_columns, d_depth: Rows, columns and depth (grid count) of the original data

int blockId = blockIdx.x + blockIdx.y * gridDim.x   // Offset of the block on its grid
              + blockIdx.z * gridDim.x * gridDim.y; // Offset of the grid this block is in

index = blockId * (blockDim.x * blockDim.y * blockDim.z) // Offset of the block this thread is in
        + (threadIdx.z * (blockDim.x * blockDim.y))      // Offset of this thread inside 3D block
        + (threadIdx.y * blockDim.x) + threadIdx.x;      // Offset of this thread inside 2D block

if (index < d_rows * d_columns * d_depth) {
   // ... This thread index is inside data range, perform processing.
}

```

## Referencias
* [Execution Configuration](https://docs.nvidia.com/cuda/cuda-c-programming-guide/index.html#execution-configuration) en la documentación oficial de NVIDIA.