# Week 3
Definition of functions employed on each task

##Task 1 - Connected Components


##Task 2 - Sliding Window
  
  ###slideWindow(Imag,WinSize,step,fr_threshold)
  
  Imag: Input image
  WinSize: Sliding window size
  step: window step size
  fr_threshold: min filling ratio to consider valid region
    

##Task 3 - Sliding Window (Integral Image)
  
  ###slideWindowWithIntegra(Imag,WinSize,step,fr_threshold)
  
  Imag: Input image
  WinSize: Sliding window size
  step: window step size
  fr_threshold: min filling ratio to consider valid region
      

##Task 4 - Region Based Evaluation
Set up parameters step and fr_threshold applied in Slide Window functions

1. Window Evaluation
    ###task2_validation.m 
    Run to obtain Precision and Recall using simple Sliding Window

    ###task3_validation.m 
    Run to Precision and Recall using Sliding Window applying integral image

    ###task5_validation.m 
    Run to Precision and Recall files using Sliding Window applying Convolution



2. Test Submission - Generation of masks and bounding boxes
    ###task2_test.m 
    Run to generate submision files using simple Sliding Window

    ###task3_test.m 
    Run to generate submision files using Sliding Window applying integral image

    ###task5_test.m 
    Run to generate submision files using Sliding Window applying Convolution


## Task 5
###slideWindowByConv(Imag,WinSize,step,fr_threshold)
  
  Imag: Input image
  WinSize: Sliding window size
  step: window step size
  fr_threshold: min filling ratio to consider valid region
      
