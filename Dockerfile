FROM ros:noetic-ros-core
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

RUN apt-get install -y \
    ros-noetic-image-pipeline \
    ros-noetic-geometry \
    ros-noetic-rviz \
    ros-noetic-rqt-gui \
    ros-noetic-pcl-ros \
    ros-noetic-catkin \
    ros-noetic-roscpp \
    ros-noetic-cv-bridge \
    ros-noetic-class-loader \
    ros-noetic-rospy
RUN apt-get install -y \
    cmake \
    git \
    build-essential \
    unzip \
    pkg-config \
    autoconf \
    libboost-all-dev \
    libjpeg-dev \
    libpng-dev \
    libtiff-dev \
    libvtk7-dev \
    libgtk-3-dev \
    libatlas-base-dev \
    gfortran \
    libparmetis-dev \
    python3-wstool \
    python3-catkin-tools \
    libtbb-dev
RUN rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/borglab/gtsam.git /gtsam && \
    cd /gtsam && \
    git checkout 12aed1f &&\
    mkdir -p build && \
    cd build &&\
    cmake .. -DCMAKE_BUILD_TYPE=Release -DGTSAM_USE_SYSTEM_EIGEN=ON &&\
    make -j$(nproc) && \
    sudo make install

RUN sudo apt update &&\
    sudo apt install -y gpg-agent wget &&\
    wget -O- https://apt.repos.intel.com/intel-gpg-keys/GPG-PUB-KEY-INTEL-SW-PRODUCTS.PUB | gpg --dearm>
    echo "deb [signed-by=/usr/share/keyrings/oneapi-archive-keyring.gpg] https://apt.repos.intel.com/on>
    sudo apt update &&\
    sudo apt install intel-oneapi-mkl-devel -y

RUN mkdir -p /root/catkin_ws/src/
RUN git clone https://github.com/bharadwajsirigadi/WAIS.git /root/catkin_ws/src/WAIS
RUN git clone https://github.com/ros/catkin.git /root/catkin_ws/src/catkin

RUN echo "source /opt/ros/noetic/setup.bash" >> /root/.bashrc
RUN /bin/bash -c "source /opt/ros/noetic/setup.bash"

RUN /bin/bash -c "source /opt/ros/noetic/setup.bash && cd /root/catkin_ws && catkin build -DMKL_DIR=/op>
RUN echo "source /root/catkin_ws/devel/setup.bash" >> /root/.bashrc
