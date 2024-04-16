# A Coupled Tensor Double-Factor Method for Hyperspectral and Multispectral Image Fusion
Ting Xu, Ting-Zhu Huang*, Liang-Jian Deng*, Jin-Liang Xiao, Clifford Broni-Bediako, Junshi Xia, Naoto Yokoya

IEEE Transactions on Geoscience and Remote Sensing, 2024.

**Homepage:**  https://tingxu113.github.io/

![TDF degradation model from the HR-HSI to both MSI and HSI.](https://github.com/tingxu113/tingxu113.github.io/blob/main/assets/img/CTDF.png)

# How to use?
- Directly run: ``demo_Pavia.m`` 

# Parameters

  | Parameters | Meaning | Adjustment scope |
  | :-----:| :----: | :----: |
  | **K** | Iteration number | [3,20] |
  | **r1, r2** | TDF-rank | [2,9],[4,8] |
  | **rho** | Penalty parameter | [1e-8,1e-4] |


**Please adjust the above parameters for better results**
 
# Citation
```bibtex
@ARTICLE{xu2024ctdf,
  author={Xu, Ting and Huang, Ting-Zhu and Deng, Liang-Jian and Xiao, Jin-Liang and Broni-Bediako, Clifford and Xia, Junshi and Yokoya, Naoto},
  journal={IEEE Transactions on Geoscience and Remote Sensing}, 
  title={A Coupled Tensor Double-Factor Method for Hyperspectral and Multispectral Image Fusion}, 
  year={2024},
  volume={},
  number={},
  pages={1-1},
  doi={10.1109/TGRS.2024.3389016}
}
```
