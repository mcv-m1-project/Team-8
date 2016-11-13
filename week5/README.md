# Week 5

## Task 1 - Hough Filtering

Scripts:

- task1_fit_params: we used this script to adjust the
  threshold for Task 1. It execute a test with the validation
  folder and ouputs some performance measures (F1-score, TP, FP,
  etc.)

- task1_test: script for the Task 1 submission. It performs backprojection,
  morphology, connected component analysis and Hough filtering. The script
  generates a folder with the results of applying this pipeline to
  the test dataset.


## Task 2 - Improve segmentation

Scripts:

- task2_fit_params: this script evaluates several thresholds to filter
  the partitions produced by the ucm algorithm. This helps us to find
  the best parameters for our ucm segmentation approach.

- task2_test: this script creates the submission for Task 2. We use UCM
  segmentation and some subsequent filters to detect signals in the image.
  The script generates a folder with the results of applying the system
  to the test dataset.


