# Figure 3b - d
# Selected spectrogram images

import librosa
import matplotlib.pyplot as plt
import numpy as np


# Plot function
def plotMelspec(audio, plotfile, offset=0, duration=3):
  y, sr = librosa.load(audio, sr=16000, offset=offset, duration=duration)
  melspec = librosa.feature.melspectrogram(y=y, sr=sr, n_fft=1024, hop_length=280)
  melspec_db = librosa.power_to_db(melspec, ref=np.max, top_db=50)
  
  plt.figure(figsize=(2, 0.6))
  librosa.display.specshow(melspec_db, sr=sr)
  plt.subplots_adjust(left=0, right=1, bottom=0, top=1)
  plt.savefig(plotfile, dpi=600)
  plt.close()


# You need to download the audio file from the data repository (see README.md)
# 3b: Oct 07 2023, wild sounds including B. choui, P. leucomystax, and R. marina
plotMelspec("annotated-samples/train/BUECHO,POLLEU,RHIMAR/NKSN_Okinawa_20231007_210000_48_51.wav", "figs/Fig3b.png")

# 3c: Jul 29 2023, playback of P. leucomystax
plotMelspec("data/playback/YMBK_playback_20230729_POLLEU_2.wav", "figs/Fig3c.png", offset=3, duration=3)

# 3d: Dec 28, playback of P. leucomystax
plotMelspec("data/playback/YMBK_playback_20231228_POLLEU_1.wav", "figs/Fig3d.png", offset=18, duration=3)

# 3e: Dec 28, playback of RHIMAR
plotMelspec("data/playback/YMBK_playback_20231228_RHIMAR_1.wav", "figs/Fig3e.png", offset=9, duration=3)
