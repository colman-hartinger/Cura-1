FROM ultimaker/cura-build-environment:python3.7-debian-latest

# Environment vars for easy configuration
ENV CURA_APP_DIR=/srv/cura

# Ensure our sources dir exists
RUN mkdir $CURA_APP_DIR

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

# Run Cura
WORKDIR $CURA_APP_DIR/Cura
ENV PYTHONPATH=${PYTHONPATH}:$CURA_APP_DIR/Uranium:$CURA_APP_DIR/Cura-1
RUN apt-get install -y mesa-utils xvfb
# RUN cd CuraX
RUN chmod +x ./run_in_docker.sh
CMD "./run_in_docker.sh"
