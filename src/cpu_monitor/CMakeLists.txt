cmake_minimum_required(VERSION 2.8.3)
if(POLICY CMP0048)
  cmake_policy(SET CMP0048 NEW)
endif()

project(cpu_monitor VERSION 0.1.0)

find_package(catkin REQUIRED COMPONENTS rospy)
catkin_package()
install(PROGRAMS
   monitor.py
   DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
install(DIRECTORY launch 
  DESTINATION ${CATKIN_PACKAGE_SHARE_DESTINATION}
  PATTERN *~ EXCLUDE
)


