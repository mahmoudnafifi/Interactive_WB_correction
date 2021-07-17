# Interactive White Balancing for Camera-Rendered Images
*[Mahmoud Afifi](https://sites.google.com/view/mafifi)* and  *[Michael S. Brown](http://www.cse.yorku.ca/~mbrown/)*
<br></br>York University


![teaser](https://user-images.githubusercontent.com/37669469/80855751-b8bdca80-8c11-11ea-8b72-6669ce010c20.jpg)


Reference code for the paper [Interactive White Balancing for Camera-Rendered Images](https://arxiv.org/abs/2009.12632) Mahmoud Afifi and Michael S. Brown. In Color and Imaging Conference (CIC), 2020. If you use this code, please cite our paper:
```
@inproceedings{afifi2020interactive,
  title={Interactive White Balancing for Camera-Rendered Images},
  author={Afifi, Mahmoud and Brown, Michael S},
  booktitle={Color and Imaging Conference (CIC)},
  pages={},
  year={2020}
}
```
<p align="center">
  <img width = 90% src=https://user-images.githubusercontent.com/37669469/106653295-97a15600-6564-11eb-95b5-7c1deb675eb4.gif>
 </p>

### Abstract
White balance (WB) is one of the first photo-finishing steps used to render a captured image to its final output. WB is applied to remove the color cast caused by the scene's illumination. Interactive photo-editing software allows users to manually select different regions in a photo as examples of the illumination for WB correction (e.g., clicking on achromatic objects). Such interactive editing is possible only with images saved in a raw image format. This is because raw images have no photo-rendering operations applied and photo-editing software is able to apply WB and other photo-finishing procedures to render the final image. Interactively editing WB in camera-rendered images is significantly more challenging. This is because the camera hardware has already applied WB to the image and subsequent nonlinear photo-processing routines. These nonlinear rendering operations make it difficult to change the WB post-capture. The goal of this paper is to allow interactive WB manipulation of camera-rendered images. This approach is an extension to [our recent work](https://github.com/mahmoudnafifi/WB_sRGB) that proposed a post-capture method for WB correction based on nonlinear color-mapping functions. We introduce a new framework that is able to link the nonlinear color-mapping functions directly to the user's selected colors to allow interactive WB manipulation. Lastly, we describe how our framework can leverage a simple illumination estimation method (i.e., gray-world) to perform auto-WB correction that is on a par with the WB correction achieved by the state-of-the-art methods.

![main](https://user-images.githubusercontent.com/37669469/80855488-9a56cf80-8c0f-11ea-9fac-f4713b2f9e1d.jpg)

### Get Started

Check `generateModel.m` to re-generate our model. 

The code in `demo.m` and `demo_images.m` perform auto WB using gray-world initial estimation with our rectification function.

Run `GUI/main.m` to interactively manipulate the WB of your photos. 

### License 
This work is licensed under the [Creative Commons Attribution NonCommercial ShareAlike 4.0 License](https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode).


## Related Research Projects
- [When Color Constancy Goes Wrong](https://github.com/mahmoudnafifi/WB_sRGB): The first work to directly address the problem of incorrectly white-balanced images; requires a small memory overhead and it is fast (CVPR 2019).
- [Deep White-Balance Editing](https://github.com/mahmoudnafifi/Deep_White_Balance): A multi-task deep learning model for post-capture white-balance correction and editing (CVPR 2020).
- [White-Balance Augmenter](https://github.com/mahmoudnafifi/WB_color_augmenter): An augmentation technique based on camera WB errors (ICCV 2019).
