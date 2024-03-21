import numpy as np
from scipy.sparse import random as sparse_random
from scipy.sparse import coo_matrix, csr_matrix
import argparse

def generate_sparse_matrix(m, n, density=0.1):
    """
    Generate an m x n sparse matrix with entries randomly set to 0 or 1.
    
    Parameters:
    - m: int, the number of rows in the matrix.
    - n: int, the number of columns in the matrix.
    - density: float, the density of the non-zero elements in the matrix. This is a value between 0 and 1,
               where 1 means a completely dense matrix and 0 means a matrix with no non-zero elements.
    
    Returns:
    - csr_matrix, the generated m x n sparse matrix in CSR format.
    """
    # Generate a sparse matrix with random values
    random_matrix = sparse_random(m, n, density=density, format='coo', dtype=float)
    
    # Binarize the matrix: convert all non-zero values to 1
    random_matrix.data = np.ones_like(random_matrix.data)
    
    # Convert to CSR format for efficient arithmetic and matrix-vector operations
    binarized_matrix = random_matrix.tocsr()
    
    return binarized_matrix


if __name__ == '__main__':
    # Example usage
    parser = argparse.ArgumentParser(description="Generate a sparse matrix with specified dimensions and density.")
    parser.add_argument('n', type=int, help="Number of rows (height) of the matrix")
    parser.add_argument('m', type=int, help="Number of columns (width) of the matrix")
    parser.add_argument('--density', type=float, default=0.5, help="Density of the non-zero elements in the matrix")
    
    # Parse arguments
    args = parser.parse_args()
    # Adjust numpy print options
    np.set_printoptions(linewidth=np.inf)
    
    density = 0.5  # Define the density of non-zero elements
    sparse_matrix = generate_sparse_matrix(args.m, args.n, density)
    results = sparse_matrix.toarray() # To view the generated matrix
    # Define the filename
    filename = f"sparse_{args.m}_{args.n}.txt"

        # Save the array to a file
    with open(filename, 'w') as f:
        for row in results:
            # Converting each row to a string and writing to the file
            np.savetxt(f, row[np.newaxis], fmt='%g')

    print(results)
    print(f"Matrix saved to {filename}")
    
