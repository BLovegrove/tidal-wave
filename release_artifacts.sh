#!/bin/bash
VERSION="${1:-latest}"

command -v python3 >/dev/null 2>&1 || { echo >&2 "I require Python3 but it's not installed.  Aborting."; exit 1; }
PY3VERSION="$(command -v python3)" -c "import sys;print('.'.join(map(str, sys.version_info[:2])))"

if ! command -v cargo &> /dev/null;
then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh  # install cargo for pyapp
fi

/usr/bin/env python3 -m venv ./venv && \
    source ./venv/bin/activate && \
    python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install -r requirements.txt && \
    python3 -m pip install build shiv twine && \
    python3 -m shiv --compressed --reproducible -c tidal-wave -o ~/tools/tidal-wave_${VERSION}.pyz .  && \  # shiv executable
    PYAPP_PROJECT_NAME=tidal-wave PYAPP_PROJECT_VERSION=${VERSION} PYAPP_DISTRIBUTION_EMBED=1 PYAPP_PYTHON_VERSION=3.11 cargo install pyapp --root out && \
    mv out/bin/pyapp ~/tools/tidal-wave_${VERSION}_py311.pyapp && \
    rm -r out/

# Pyinstaller executable is licensed under LGPL-2.1 as it bundles FFmpeg
mkdir ~/ffmpeg_build ~/bin && \
    cd FFmpeg-6.1.1 && \
    PATH="$HOME/bin:$PATH" PKG_CONFIG_PATH="$HOME/ffmpeg_build/lib/pkgconfig" ./configure \
      --prefix="$HOME/ffmpeg_build" \
      --pkg-config-flags="--static" \
      --extra-cflags="-I$HOME/ffmpeg_build/include" \
      --extra-ldflags="-L$HOME/ffmpeg_build/lib" \
      --extra-libs="-lpthread -lm" \
      --ld="g++" \
      --bindir="$HOME/bin" \
      --disable-doc \
      --disable-htmlpages \
      --disable-podpages \
      --disable-txtpages \
      --disable-network \
      --disable-autodetect \
      --disable-hwaccels \
      --disable-ffprobe \
      --disable-ffplay \
      --disable-encoder=adpcm* \
      --disable-encoder=av1* \
      --disable-encoder=hevc* \
      --disable-encoder=libmp3lame \
      --disable-encoder=vp* \
      --disable-decoder=av1* \
      --disable-decoder=hevc* \
      --disable-decoder=adpcm* \
      --disable-decoder=mp3* \
      --disable-decoder=vp* \
      --enable-small
      && \
    PATH="$HOME/bin:$PATH" make -j$(nproc) && \
    make install && \
    ./venv/bin/pyinstaller \
        --distpath ~/.dist \
        --workpath ~/.build \
        --onefile \
	--clean \
	--strip \
	--noupx \
        --name tidal-wave_linux \
        --paths tidal_wave \
        --add-data "README.md:." \
        --add-data "$HOME/bin/ffmpeg:." \
        ./pyinstall.py && \
    rm -r ./.dist/ ./.build/ ~/bin ~/ffmpeg_build
