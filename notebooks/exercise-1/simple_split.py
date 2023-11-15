import numpy as np
import flopy

def simple_mapping(
    nrow_blocks: int,
    ncol_blocks: int,
    modelgrid: flopy.discretization.StructuredGrid,
) -> np.ndarray:
    """
    Create a simple block-based mapping array for a structured grid

    Parameters
    ----------
    nrow_blocks: int
        Number of models in the row direction of a domain.
    ncol_blocks: int
        Number of models in the column direction of a domain.
    modelgrid: flopy.discretization.StructuredGrid
        flopy modelgrid object

    Returns
    -------
    mask: np.ndarray
        block-based mapping array for the model splitter

    """
    if modelgrid.grid_type != "structured":
        raise ValueError(
            f"modelgrid must be 'structured' not {modelgrid.grid_type}"
        )
    nrow, ncol = modelgrid.nrow, modelgrid.ncol
    row_inc, col_inc = int(nrow / nrow_blocks), int(ncol / ncol_blocks)

    # create a list of row boundaries
    icnt = 0
    row_blocks = [icnt]
    for i in range(nrow_blocks):
        icnt += row_inc
        row_blocks.append(icnt)
    if row_blocks[-1] < nrow:
        row_blocks[-1] = nrow

    # create a list of column boundaries
    icnt = 0
    col_blocks = [icnt]
    for i in range(ncol_blocks):
        icnt += col_inc
        col_blocks.append(icnt)
    if col_blocks[-1] < ncol:
        col_blocks[-1] = ncol

    # create masking array - zero-based model number
    mask = np.zeros((nrow, ncol), dtype=int)
    ival = 0
    model_row_col_offset = {}
    for idx in range(len(row_blocks) - 1):
        for jdx in range(len(col_blocks) - 1):
            mask[
                row_blocks[idx] : row_blocks[idx + 1],
                col_blocks[jdx] : col_blocks[jdx + 1],
            ] = ival
            model_row_col_offset[ival - 1] = (row_blocks[idx], col_blocks[jdx])
            # increment model number
            ival += 1

    return mask