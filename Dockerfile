FROM ultimaker/cura-build-environment:latest

# Environment vars for easy configuration
ENV CURA_APP_DIR=/srv/cura

# Ensure our sources dir exists
RUN mkdir $CURA_APP_DIR

# # Setup CuraEngine
# ENV CURA_ENGINE_BRANCH=master
# WORKDIR $CURA_APP_DIR
# RUN git clone -b $CURA_ENGINE_BRANCH --depth 1 https://github.com/Ultimaker/CuraEngine
# WORKDIR $CURA_APP_DIR/CuraEngine
# RUN mkdir build
# WORKDIR $CURA_APP_DIR/CuraEngine/build
# RUN cmake3 ..
# RUN make
# RUN make install

# TODO: setup libCharon

# Setup Uranium
ENV URANIUM_BRANCH=master
WORKDIR $CURA_APP_DIR
RUN git clone -b $URANIUM_BRANCH --depth 1 https://github.com/Ultimaker/Uranium

# Setup materials
ENV MATERIALS_BRANCH=master
WORKDIR $CURA_APP_DIR
RUN git clone -b $MATERIALS_BRANCH --depth 1 https://github.com/Ultimaker/fdm_materials materials

# Setup Cura
WORKDIR $CURA_APP_DIR/Cura
ADD . .
RUN mv $CURA_APP_DIR/materials resources/materials

# Make sure Cura can find CuraEngine
# RUN ln -s /usr/local/bin/CuraEngine $CURA_APP_DIR/Cura docker build --tag cura_dev:1.0 .


# Run Cura
WORKDIR $CURA_APP_DIR/Cura
ENV PYTHONPATH=${PYTHONPATH}:$CURA_APP_DIR/Uranium
# RUN yum upgrade -y
# RUN yum install -y xorg-x11-server-Xvfb freeglut-devel mesa-libGL
ENV DISPLAY:1
RUN chmod +x ./run_in_docker.sh
CMD "./run_in_docker.sh"
