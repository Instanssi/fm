# README

Tools for broadcasting on FM and DRM using LimeSDR.

This file covers FM broadcast. If you want to broadcast DRM radio, see
[DRM.md](DRM.md).

## Installing
	
Install requirements:

	sudo apt install gnuradio gr-osmosdr python-systemd

Also, install LimeSuite if you are using LimeSDR.

Clone repo:

	git clone https://github.com/Instanssi/fm

Compile gnu radio block:

	make

### Jack

Most likely you want to route your audio with JACK. In that case you
don't have physical sound card (it's not needed at all!), you may use
the following systemd job:

```
[Unit]
Description=Jack

[Service]
ExecStart=/usr/bin/jackd -R -P 4 -ddummy -r 192000 -P0 -C0
ExecStartPost=/bin/sleep 5
Restart=always
RestartSec=30
```

NB! sleep is just to ensure JACK gets fully running before startup
finishes. Please submit me a patch for fixing that issue.

Also, add the following contents to `~/.gnuradio/config.conf`:

```
[audio]
audio_module = jack
```

## Stereo Tool

If you can cope with proprietary software for MPX generation I
recommend using [Stereo Tool](https://www.stereotool.com/).

Our production settings for Stereo Tool can be found in file
[instanssi.sts](instanssi.sts).

Stereo tool has realtime priority option in settings. It's more than
recommended. You can also make it real-time after launch by running:

```sh
sudo chrt -p --rr 99 STEREOTOOL_PID
```
