# Intensity-Sensitive Image Quality Assessment (IQA) Metrics

We have developed three IQA metrics for assessing low-information image in fields such as radio astrnomical imaging, medical imaging, and remote sensing. They are InTensity Weighted Structural SIMilarity (ITW-SSIM), Low-Information Similarity Index (LISI), and augmented Low-Information Similarity Index (augLISI). Please see our papers in Section [Reference](https://github.com/egbdfX/Intensity-sensitive-IQAs/tree/main#reference) for more information.

# ITW-SSIM

## Description

**itw**: Intensity Weighted SSIM Index (ITW-SSIM) for measuring image quality.

```out = itw(recon,ref,varargin)``` calculates the ITW-SSIM value for image ```recon```, with the image ```ref``` as the reference. ```recon``` and ```ref``` must be of the same size and class. The output ITW-SSIM, ```out```, is a double valued scalar. The weighting mode ```varargin``` needs to be inputted with ```'Gau'``` for Gaussian-based weighting function, ```'tanh'``` for tanh-based weighting function, and ```'sigm'``` for sigmoid-based weighting function.

## Reference

When referencing ITW-SSIM or LISI, please cite our related paper:

X. Li and W. Armour, "Intensity-Sensitive Similarity Indexes for Image Quality Assessment," 2022 26th International Conference on Pattern Recognition (ICPR), Montreal, QC, Canada, 2022, pp. 1975-1981, doi: 10.1109/ICPR56361.2022.9956093.

When referencing augLISI, please cite our related paper:

X. Li, K. Adámek, W. Armour, "Intensity-sensitive quality assessment of extended sources in astronomical images," 2023.

## License

Shield: [![CC BY 4.0][cc-by-shield]][cc-by]

This work is licensed under a
[Creative Commons Attribution 4.0 International License][cc-by].

[![CC BY 4.0][cc-by-image]][cc-by]

[cc-by]: http://creativecommons.org/licenses/by/4.0/
[cc-by-image]: https://i.creativecommons.org/l/by/4.0/88x31.png
[cc-by-shield]: https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey.svg
