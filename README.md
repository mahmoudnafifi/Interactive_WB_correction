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


### Related Research Projects
- sRGB Image White Balancing:
  - [When Color Constancy Goes Wrong](https://github.com/mahmoudnafifi/WB_sRGB): The first work for white-balancing camera-rendered sRGB images (CVPR 2019).
  - [White-Balance Augmenter](https://github.com/mahmoudnafifi/WB_color_augmenter): Emulating white-balance effects for color augmentation; it improves the accuracy of image classification and image semantic segmentation methods (ICCV 2019).
  - [Color Temperature Tuning](https://github.com/mahmoudnafifi/ColorTempTuning): A camera pipeline that allows accurate post-capture white-balance editing (CIC best paper award, 2019).
  - [Deep White-Balance Editing](https://github.com/mahmoudnafifi/Deep_White_Balance): A multi-task deep learning model for post-capture white-balance editing (CVPR 2020).
- Raw Image White Balancing:
  - [APAP Bias Correction](https://github.com/mahmoudnafifi/APAP-bias-correction-for-illumination-estimation-methods): A locally adaptive bias correction technique for illuminant estimation (JOSA A 2019).
  - [SIIE](https://github.com/mahmoudnafifi/SIIE): A sensor-independent deep learning framework for illumination estimation (BMVC 2019).
  - [C5](https://github.com/mahmoudnafifi/C5): A self-calibration method for cross-camera illuminant estimation (arXiv 2020).
- Image Enhancement:
  - [Exposure Correction for sRGB Images](https://github.com/mahmoudnafifi/Exposure_Correction): A coarse-to-fine deep learning model with adversarial training to correct badly-exposed photographs (CVPR 2021).
  - [CIE XYZ Net](https://github.com/mahmoudnafifi/CIE_XYZ_NET): Mapping to an accurate camera-rendering linearization for different computer vision tasks; e.g., denoising, deblurring, and image enhancement (arXiv 2020).
 - Image Manipulation:
    - [Image Blending](https://github.com/mahmoudnafifi/modified-Poisson-image-editing): Less bleeding artifacts by a simple two-stage Poisson blending approach (CVM 2016).
    - [Image Recoloring](https://github.com/mahmoudnafifi/Image_recoloring): A fully automated image recoloring without needing for target/reference images (Eurographics 2019).
    - [Image Relighting](https://github.com/mahmoudnafifi/image_relighting): As an intermediate stage, producing a uniformly-lit white-balanced image could help to eventually produce high-quality relit images (Runner-Up Award overall tracks of AIM 2020 challenge for image relighting, ECCV 2020). 
    - [HistoGAN](https://github.com/mahmoudnafifi/HistoGAN): Control colors of GAN-generated images based on features derived directly from color histograms (CVPR 2021). 
