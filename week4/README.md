# Week 4
Definition of functions employed on each task

## Task 0 - Sliding Window
###CandidateBoxesByWindow(Imag,step,fr_threshold,margin)

  *Imag: Input image.
  *step: window step size.
  *fr_threshold: min filling ratio to consider valid region.
  *margin: minimum overlapped pixels of two candidates to keep just one of them


## Task 1 - Template matching with correlation
#### task1_test
  
  * xcorr_thr: minimum cross correlation to match a region.
  * pyr_scales: image pyramid factors for each level.
  * overlap_thr: maximum overlapping.
    

## Task 2 - Template matching using edges 
#### task2_test
  
  * dist_thresh: maximum distance on the line of the edges of the template in a crop to keep it as a candidate


### Edge templates generation:
* **task2_edge_templates.m** : Run to generate in edge_templates edges of the templates in image_templates


### Candidate Evaluation
* **task1_validation.m** : Run to obtain Precision and Recall using correlation for matching.

* **task2_validation.m** : Run to Precision and Recall using Chamfer distance for matching.


