# DRM broadcasting with Dream

## Pulseaudio loopbacks

Let's have a Pulseaudio sink where to feed the input audio for the
encoder.

```
pacmd load-module module-null-sink sink_name=to_radio
```

## Dream

Dream is a free software DRM encoder. The code quality varies but it
is usable.

### Building

Get the sources:

	git svn clone svn://svn.code.sf.net/p/drm/code/dream

Compiling Dream without GUI for tx use to ease running it from a
systemd service. To do that, replace CONFIG at the beginning of file
`dream.pro` with the following:

	CONFIG += warn_on qtconsole

Then run:

	qmake
	make

If you want to have the graphical user interface as well you can now
rename the binary as `dream-console` and then rebuild the project with
default config.

### Configuration

Setup Dream.ini:

```
[Transmitter]
currenttime=CT_OFF
hqiq=0
ifamp=1
ifformat=OF_IQ_POS
iffreq=-4510.0000000
interleaver=SI_LONG
msc=CS_3_SM
protlevel=1
robustness=RM_ROBUSTNESS_MODE_A
samplerateaud=48000
sampleratesig=48000
sdc=CS_2_SM
snddevin=to_radio.monitor
snddevout=-2
spectocc=SO_4

[Transmitter Service 1]
codec=Opus
description=15
id=0
label=MyStation
language=0
Opus_Application=OA_AUDIO
Opus_Bandwith=OB_FB
Opus_Channels=OC_STEREO
Opus_FEC=0
Opus_Signal=OG_MUSIC
```

The important part is to have `snddevout=-2` as it is a magic number
which enables writing I/Q samples to stdout when used with
`ifformat=OF_IQ_POS`.

TODO Other options still need investigating, especially high quality IQ mode

TODO setting up limesdr transmitter

## Transmitting

	{ sleep 6; chrt --rr 95 ./dream -t; } | ./lime_iq_tx.py -f 144.7

Scaling:

	chrt --rr 95 ./dream -t | sox -t raw -r 48k -e signed -b 16 -c 2 - -n stat
