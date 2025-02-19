[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![PyPI - Version](https://img.shields.io/pypi/v/tidal-wave)](https://pypi.org/project/tidal-wave/)
[![PyPI - Downloads](https://img.shields.io/pypi/dm/tidal-wave)](https://pypi.org/project/tidal-wave/)
[![Build Python package](https://github.com/ebb-earl-co/tidal-wave/actions/workflows/python-build.yml/badge.svg?branch=trunk&event=release)](https://github.com/ebb-earl-co/tidal-wave/actions/workflows/python-build.yml)
[![Docker Image CI](https://github.com/ebb-earl-co/tidal-wave/actions/workflows/docker-image.yml/badge.svg?branch=trunk)](https://github.com/ebb-earl-co/tidal-wave/actions/workflows/docker-image.yml)

# My changes:
Theres probably a better way to do all these things, but this is the best way I know at this point!
- Check the [docker example](https://github.com/BLovegrove/tidal-wave#docker-example) below! Made a small change to how that works.
- Album name now does not include the album ID and replaces the square brackets around the year with round brackets. This part is just personal preference! The new format is 'AlbumName (AlbumYear)'
- Killed playlist folders - drops everything into base music directory as if you downloaded it via an album link. This should keep duplicates down if you're like me and have tons of playlists you arent always super careful of (':

# tidal-wave
Waving at the [TIDAL](https://tidal.com) music service. Runs on (at least) Windows, macOS, and GNU/Linux.

>  TIDAL is an artist-first, fan-centered music streaming platform that delivers over 100 million songs in HiFi sound quality to the global music community. © 2024 TIDAL Music ASimplementation

This project is inspired by [`qobuz-dl`](https://github.com/vitiko98/qobuz-dl), and, particularly, is a continuation of [`Tidal-Media-Downloader`](https://github.com/yaronzz/Tidal-Media-Downloader). **This project is intended for private use only: it is not intended for distribution of copyrighted content**.

This software uses libraries from the [FFmpeg](http://ffmpeg.org) project under the [LGPLv2.1](http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html). FFmpeg is a trademark of [Fabrice Bellard](http://www.bellard.org/), originator of the FFmpeg project. 

## Features
* Download [FLAC](https://xiph.org/flac/), [Dolby Atmos](https://www.dolby.com/technologies/dolby-atmos/), [Sony 360 Reality Audio](https://electronics.sony.com/360-reality-audio), or [AAC](https://en.wikipedia.org/wiki/Advanced_Audio_Coding) tracks; [AVC/H.264](https://en.wikipedia.org/wiki/Advanced_Video_Coding) (up to 1920x1080) + [AAC](https://en.wikipedia.org/wiki/Advanced_Audio_Coding) videos
* Either a single track or an entire album can be downloaded
* Album covers and artist images are downloaded by default
* Support for albums with multiple discs
* If available, lyrics are added as metadata to tracks
* If available, album reviews are downloaded as JSON 
* Video download support
* Playlist download support (video or audio or both)
* Mix download support (video or audio)
* Artist's entire works download support (video and audio; albums or albums and EPs and singles)

## Getting Started
A [HiFi Plus](https://tidal.com/pricing) account is **required** in order to retrieve HiRes FLAC, Dolby Atmos, and Sony 360 Reality Audio tracks. Simply a [HiFi](https://tidal.com/pricing) plan is sufficient to download in 16-bit, 44.1 kHz (i.e., lossless) or lower quality as well as videos. More information on sound quality at [TIDAL's site here](https://tidal.com/sound-quality).

### Requirements
 - As resources will be fetched from the World Wide Web, an Internet connection is required
 - The excellent tool [FFmpeg](http://ffmpeg.org/download.html) is necessary for audio file manipulation. The [container image](https://github.com/ebb-earl-co/tidal-wave/blob/trunk/Dockerfile) as well as the [`pyinstaller`](https://pyinstaller.org/en/stable/)-created [binary for GNU/Linux](https://github.com/ebb-earl-co/tidal-wave/releases/latest/download/tidal-wave_py311_FFmpeg6.1.1_linux), [binary for Apple Silicon macOS](https://github.com/ebb-earl-co/tidal-wave/releases/latest/download/tidal-wave_py311_FFmpeg6.1.1_macos_arm64), [binary for x86\_64 macOS](https://github.com/ebb-earl-co/tidal-wave/releases/latest/download/tidal-wave_py311_FFmpeg6.1.1_macos_x86_64) build FFmpeg from source, so separate installation is unnecessary.
   - Static builds are available from [John Van Sickle](https://www.johnvansickle.com/ffmpeg/) for GNU/Linux, or most package managers feature `ffmpeg`.
   - For macOS, the [FFmpeg download page](http://ffmpeg.org/download.html#build-mac) links to [this download source](https://evermeet.cx/ffmpeg/), or there is always [Homebrew](https://formulae.brew.sh/formula/ffmpeg)
   - For Windows, the [FFmpeg download page](http://ffmpeg.org/download.html#build-windows) lists 2 resources; or [`chocolatey`](https://community.chocolatey.org/packages/ffmpeg) is an option
 - This is a Python package, so **to use it in the default manner** you will need [Python 3](https://www.python.org/downloads/) on your system: this tool supports Python 3.8 or newer.
   - *However*, as of version 2023.12.10, an [OCI container image](https://github.com/ebb-earl-co/tidal-wave/pkgs/container/tidal-wave); a [`pyapp`-compiled binaries](https://github.com/ebb-earl-co/tidal-wave/releases/latest); and [`pyinstaller`](https://pyinstaller.org/en/stable/)-created binaries for x86\_64 GNU/Linux, Apple Silicon macOS, and x86\_64 macOS are provided for download and use that *do not require Python installed*
 - Only a handful of Python libraries are dependencies:
   - [`backoff`](https://pypi.org/project/backoff/)
   - [`dataclass-wizard`](h#docker-examplettps://pypi.org/project/dataclass-wizard/)
   - [`ffmpeg-python`](https://pypi.org/project/ffmpeg-python/)
   - [`mutagen`](https://pypi.org/project/mutagen/)
   - [`m3u8`](https://pypi.org/project/m3u8/)
   - [`platformdirs`](https://pypi.org/project/platformdirs/)
   - [`requests`](https://pypi.org/project/requests/)
   - [`typer`](https://pypi.org/project/typer/)

## Installation
### `pip` Install from PyPi
Install this project with [`pip`](https://pip.pypa.io/en/stable/): either with a virtual environment (preferred) or any other way you desire:
```bash
$ python3 -m pip install tidal-wave
```

Optionally, to get the full `typer` experience when using this utility, add `[all]` to the end of the `pip install command`:
```bash
$ python3 -m pip install tidal-wave[all]
```
### `pip` Install from the Repository
Alternatively, you can clone this repository; `cd` into it; and install from there:
```bash
$ git clone --depth=1 https://github.com/ebb-earl-co/tidal-wave.git
$ cd tidal-wave
$ python3 -m venv .venv
$ source .venv/bin/activate
$ (.venv) pip install .
```
### `Pyinstaller` executable
This is the preferred release artifact, compiled with [`pyinstaller`](https://pyinstaller.org). It bundles Python 3.11, FFmpeg 6.1.1, and the `tidal-wave` program into one binary, licensed under the terms of FFmpeg: with the [GNU Lesser General Public License (LGPL) version 2.1](https://www.gnu.org/licenses/old-licenses/lgpl-2.1.html). Installation is as simple as downloading the correct binary for your platform (currently, GNU/Linux x86\_64; macOS x86\_64; or macOS arm64), giving it execute permissions, and running it.
```bash
$ wget https://github.com/ebb-earl-co/tidal-wave/releases/latest/download/tidal-wave_py311_FFmpeg6.1.1_linux
$ chmod +x ./tidal-wave_py311_FFmpeg6.1.1_linux
# optionally, rename the binary because the name is descriptive, but unwieldy
$ mv ./tidal-wave_py311_FFmpeg6.1.1_linux ./tidal-wave_linux
$ ./tidal-wave_linux --help
```
### Shiv executable
As yet another option, if you don't want to mess with `pip`, you can download the `.pyz` artifact in the [releases](https://github.com/ebb-earl-co/tidal-wave/releases/latest) page. It is a binary created using the [`shiv`](https://pypi.org/project/shiv/) project and is used in the following way:
```bash
# download the .pyz file of the latest (or your desired) release
$ wget https://github.com/ebb-earl-co/tidal-wave/releases/latest/download/tidal-wave.pyz
$ ./tidal-wave.pyz --help
```
### `pyapp` executable
Download the Rust-compiled binary from [the Releases](https://github.com/ebb-earl-co/tidal-wave/releases/latest), and, on macOS or GNU/Linux, make it executable
```bash
$ wget https://github.com/ebb-earl-co/tidal-wave/releases/latest/download/tidal-wave_py311.pyapp
$ chmod +x ./tidal-wave_py311.pyapp
```
Or, on Windows, once the .exe file is downloaded, you might have to allow a security exception for an unknown developer, then:
```powershell
Invoke-WebRequest https://github.com/ebb-earl-co/tidal-wave/releases/latest/download/tidal-wave_py311_pyapp.exe
& "tidal-wave_py311_pyapp.exe" --help
```

### Docker
Pull the image from GitHub container repo:
```bash
docker pull ghcr.io/ebb-earl-co/tidal-wave:latest
```
## Quickstart
Run `python3 tidal-wave --help` to see the options available. Or, if you followed the repository cloning steps above, run `python3 -m tidal_wave --help` from the repository root directory, `tidal-wave`. In either case, you should see something like the following:
```bash
Usage: tidal-wave [OPTIONS] TIDAL_URL [OUTPUT_DIRECTORY]                                                                                                                                  
                                                                                                                                                                                            
╭─ Arguments ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ *    tidal_url             TEXT                The Tidal album or artist or mix or playlist or track or video to download [default: None] [required]                                     │
│      output_directory      [OUTPUT_DIRECTORY]  The parent directory under which directory(ies) of files will be written [default: /home/${USER}/music/]                                  │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
╭─ Options ────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╮
│ --audio-format               [360|Atmos|HiRes|MQA|Lossless|High|Low]  [default: Lossless]                                                                                                │
│ --loglevel                   [DEBUG|INFO|WARNING|ERROR|CRITICAL]      [default: INFO]                                                                                                    │
│ --include-eps-singles                                                 No-op unless passing TIDAL artist. Whether to include artist's EPs and singles with albums                         │
│ --install-completion                                                  Install completion for the current shell.                                                                          │
│ --show-completion                                                     Show completion for the current shell, to copy it or customize the installation.                                   │
│ --help                                                                Show this message and exit.                                                                                        │
╰──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────╯
```

## Usage
> By default, this tool can request (and, if no errors arise, retrieve) all of the audio formats *except* `HiRes` and `360`.

> The [HiRes FLAC](https://tidal.com/supported-devices?filter=hires-flac) format is only available if the credentials from an Android, Windows, iOS, or macOS device can be obtained

> The [Sony 360 Reality Audio](https://tidal.com/supported-devices?filter=sony-360) format is only available if the credentials from an Android or iOS device can be obtained

Invocation of this tool will store credentials in a particular directory in the user's "home" directory: for Unix-like systems, this will be `/home/${USER}/.config/tidal-wave`: for Windows, it varies: in either OS situation, the exact directory is determined by the `user_config_path()` function of the `platformdirs` package.

Similarly, all media retrieved is placed in subdirectories of the user's default music directory: for Unix-like systems, this probably is `/home/${USER}/Music`; for Windows it is probably `C:\Users\<USER>\Music`. This directory is determined by `platformdirs.user_music_path()`. 
 - If a different path is passed to the second CLI argument, `output_directory`, then all media is written to subdirectories of that directory.

### Example
 - First, find the URL of the album/artist/mix/playlist/track/video desired. Then, simply pass it as the first argument to `tidal-wave` with no other arguments in order to: *download the album/artist/mix/playlist/track in Lossless quality to a subdirectory of user's music directory and INFO-level logging* in the case of audio; *download the video in 1080p, H.264+AAC quality to a subdirectory of user's music directory with INFO-level logging* in the case of a video URL.
 ```bash
 (.venv) $ tidal-wave https://tidal.com/browse/track/226092704
 ```
 - To (attempt to) get a Dolby Atmos track, and you desire to see *all* of the log output, the following will do that
 ```bash
 (.venv) $ tidal-wave https://tidal.com/browse/track/... --audio-format atmos --loglevel debug
 ```
 **Keep in mind that authentication from an Android (preferred), iOS, Windows, or macOS device will need to be extracted and passed to this tool in order to access HiRes FLAC and Sony 360 Reality Audio versions of tracks**
 - To (attempt to) get a HiRes FLAC version of an album, and you desire to see only warnings and errors, the following will do that:
 ```bash
 $ ./tidal-wave.pyz https://tidal.com/browse/album/... --audio-format hires --loglevel warning
 ```

 - To (attempt to) get a video, the following will do that. **N.b.** passing anything to `--audio-format` is a no-op when downloading videos.
 ```bash
 $ ./tidal-wave.pyz https://tidal.com/browse/video/...
 ```

 - To (attempt to) get a playlist, the following will do that. **N.b.** passing anything to `--audio-format` is a no-op when downloading videos.
 ```bash
 > .\tidal-wave_py311_pyapp.exe https://tidal.com/browse/playlist/...
 ```

 - To (attempt to) get a mix, the following will do that. **N.b.** passing anything to `--audio-format` is a no-op when downloading videos.
 ```bash
 $ ./tidal-wave_py311.pyapp https://tidal.com/browse/mix/...
 ```

 - To (attempt to) get all of an artist's works (albums and videos, **excluding EPs and singles**) in Sony 360 Reality Audio format and verbose logging, the following will do that:
 ```bash
 (.venv) $ python3 -m tidal_wave https://listen.tidal.com/artist/... --audio-format 360 --loglevel debug
 ```

 - To (attempt to) get all of an artist's works (**including EPs and singles**), in HiRes format, the following will do that:
 ```bash
 (.venv) $ tidal-wave https://listen.tidal.com/artist/... --audio-format hires --include-eps-singles
 ```
#### Docker example
Below the line separator is the original documentation for this section, but for my use-case (which is running on unraid to have direct access to my library without messing around with network shares) the default docker implementation didnt make any sense. With the very small change I've made to the dockerfile, the image should boot and stay open forever (or until manually closed) and you can use it basically as a stripped down vm. Jump in via docker exec, run 'python3 -m tidal-wave \*args\*, and you're away laughing! Make sure you mount the same music and config directories shown in the old documentation below.
One thing that wasnt super clearly documented in the original repo, if you're following its wiki instructions for getting your android token to download HiRes audio, make sure you wipe the okhttp folder and log back into tidal / play some HiRes (labelled MAX in-app) music!! I tried this a few times and it failed, but a fresh token worked right away. If you get any issues in the future, try aquiring a new token before anything else. Do *not* place the token directly in the file found in your config directory. I think theres some kind of encoding going on behind the scenes? Whatever the case, the string stored there isn't the same as the token I pasted into the CLI so just keep that in mind (: 

------------------ original docs beyond this point!! --------------------

The command line options are the same for the Python invocation, but in order to save configuration and audio data, volumes need to be passed. If they are bind mounts to directories, **they must be created before executing `docker run` to avoid permissions issues**! For example,
```bash
$ mkdir -p ./Music/ ./config/tidal-wave/
$ docker run \
    --rm -it \
    --name tidal-wave \
    --volume ./Music:/home/debian/Music \
    --volume ./config/tidal-wave:/home/debian/.config/tidal-wave \
    ghcr.io/ebb-earl-co/tidal-wave:latest \
    https://tidal.com/browse/track/...
```

Using Docker might be an attractive idea in the event that you want to retrieve all of the videos, albums, EPs, and singles in highest quality possible for a given artist. The following Docker invocation will do that for you:
```bash
$ mkdir -p ./Music/ ./config/tidal-wave/
$ docker run \
    --name tidal-wave \
    --rm -it \
    --volume ./Music:/home/debian/Music \
    --volume ./config/tidal-wave:/home/debian/.config/tidal-wave \
    ghcr.io/ebb-earl-co/tidal-wave:latest \
    https://listen.tidal.com/artist/... \
    --audio-format hires \
    --include-eps-singles
```
## Development
The easiest way to start working on development is to fork this project on GitHub, or clone the repository to your local machine and do the pull requesting on GitHub later. In any case, there will need to be some getting from GitHub first, so, roughly, the process is:
  1. Get Python 3.8+ on your system
  2. Use a virtualenv or some other Python environment system (poetry, pipenv, etc.)
  3. Clone the repository: `$ git clone --depth=1 https://github.com/ebb-earl-co/tidal-wave/git`

    * Obviously replace the URL with your forked version if you've followed that strategy
  4. Activate the virtual environment and install the required packages (requirements.txt): `(some-virtual-env) $ python3 -m pip install -r requirements.txt`

    * optional packages to follow the coding style and build process; `shiv`, `black`: `(some-virtual-env) $ python3 -m pip install shiv black`
    * optionally, Rust and cargo in order to build the `pyapp` artifacts
    * optionally, Docker to build the OCI container artifacts
  5. From a Python REPL (or, my preferred method, an iPython session), import all the relevant modules, or the targeted ones for development:
  ```python
  from tidal_wave import album, artist, dash, hls, login, main, media, mix, models, oauth, playlist, requesting, track, utils, video
  from tidal_wave.main import *
  ```
