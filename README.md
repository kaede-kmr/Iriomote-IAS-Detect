Code and data to reproduce the figures in Kimura, K., I. Fukuyama, and K. Fukuyama. "Deep learning-based detector of invasive alien frogs, *Polypedates leucomystax* and *Rhinella marina*, on an island at invasion front" (accepted in Biological Invasions, DOI: 10.1007/s10530-025-03553-0). Larger datasets for model training and inference, as well as the custom-trained model, can be found at Open Science Framework (OSF) data repository (DOI [10.17605/OSF.IO/JU594](https://osf.io/ju594/)).



## Contents

### Data

* `preds-vs-labels-in-playback`: Compare results of human-made annotations (labels column) and BirdNET outputs (species and confidence columns). Two species included; *Polypedates leucomystax* (POLLEU) and *Rhinella marina* (RHIMAR).
* `call-segments-threshold0.5.csv`: Number of BirdNET detections, called 'number of call segments (num_call_segments)' in this csv file, for each site and species. Detection threshold was set to 0.5.
* `call-segments-threshold0.9.csv`: Detection threshold was set to 0.9.
* `call-segments-threshold0.43.csv`: Detection threshold was set to 0.43 (best threshold in terms of F1-score for *P. leycomystax* on Ishigaki Island.
* `call-segments-threshold0.92.csv`: Detection threshold was set to 0.92 (best threshold in terms of F1-score for *R. marina* on Ishigaki Island).
* `embedding.csv`: BirdNET embeddings of annotated dataset.



### Code

* `BirdNET-training-inference.sh`: Code for training and inference using custom BirdNET classifier.

* `figX_...`: R and Python scripts for plotting figures in the original article.
