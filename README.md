# SLAM
Simultaneous Localization and Mapping (SLAM) is technique used to build and generate a map from the environment it explores (mapping) for mobile robot.
The map generated is then used to determine the robot and surrounding landmark location and to make a proper path planning for the robot (localization).
The process of mapping and localizing in SLAM is done simultaneously where the map is created by the mobile robot relatively 
and mobile robot's trajectory is calculated and estimated by the created map. 

It is a well-suited solution for precise and robust mapping and localization in many applications including mobile robotics, self-driving cars, unmanned aerial
vehicles, or autonomous underwater vehicles.

# Flowchart of Algorithm
![Algorithm Flowchart](https://user-images.githubusercontent.com/70146360/133414596-9cceda48-a7fe-4581-9ba8-df4af18ba99a.png)

# Dataset 
The algorithm is tested on the 2D laser SLAM data from Deutsches Museum, Germany, which consists of 5522 batches of scanned data with 1079 intensity points per scan
i.e.  
Intensities 5522 X 1079 (double)  
Ranges 5522 X 1079 (double)  
Timestamps 5522 X 1 (double)  

# Output 
![Program running on MATLAB](https://user-images.githubusercontent.com/70146360/133416565-920ad59d-aae8-4b11-bce8-2be989d75823.png)  
The figure above shows the program running on MATLAB platform.

![Map Built and Path Traversed](https://user-images.githubusercontent.com/70146360/133416639-f55aff4c-90bb-4ea3-a08a-5d3d83e4e256.png)  
The figure above shows the final output of the program. The left image shows the map built and the right image shows the path traversed by the robot.
