FROM pytorch/pytorch

# download necessary files
RUN apt-get update && apt-get install -y --no-install-recommends \
    bash \
    curl \
    git \
    libsqlite3-0 \
    libsqlite3-dev \
    sqlite3 \
    tar \
    vim

# install pip and REL
RUN conda install -y pip

COPY . REL
RUN cd REL && \
    pip install -e .

# ????
RUN chmod -R 777 /workspace && chown -R root:root /workspace

# expose the API port
EXPOSE 5555

CMD python -m REL.server --bind 0.0.0.0 --port 5555 /workspace/data wiki_2019
