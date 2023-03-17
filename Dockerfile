FROM docker.elastic.co/elasticsearch/elasticsearch:8.6.2

ARG ES_VERSION="8.6.2"
ARG SUDACHI_VERSION="3.0.1"
ARG SUDACHI_DIC_NAME_ZIP="sudachi-dictionary-20230110-full.zip"
ARG SUDACHI_DIC_NAME="sudachi-dictionary-20230110"

RUN bin/elasticsearch-plugin install https://github.com/WorksApplications/elasticsearch-sudachi/releases/download/v3.0.1/analysis-sudachi-${ES_VERSION}-${SUDACHI_VERSION}.zip

RUN curl -Lo ${SUDACHI_DIC_NAME_ZIP} http://sudachi.s3-website-ap-northeast-1.amazonaws.com/sudachidict/${SUDACHI_DIC_NAME_ZIP} && \
    unzip ${SUDACHI_DIC_NAME_ZIP} && \
    mv ${SUDACHI_DIC_NAME}/system_full.dic /usr/share/elasticsearch/config/analysis-sudachi/ && \
    rm -rf ${SUDACHI_DIC_NAME}.zip ${SUDACHI_DIC_NAME}

COPY sudachi.json /usr/share/elasticsearh/plugin/analysis-sudachi