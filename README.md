Code and data to reproduce the figures in Kimura, Fukuyama, and Fukuyama. "Deep learning-based detector of invasive alien frogs, *Polypedates leucomystax* and *Rhinella marina*, on an island at invasion front" (submitted). Larger data for model training and inference can be found at Open Science Framework (OSF) data repository (DOI: XXXX).



## Contents

### Data

* `preds-vs-labels-in-playback`: Compare results of annotations (labels column) and BirdNET outputs (species and confidence columns). Two species included; *Polypedates leucomystax* (POLLEU) and *Rhinella marina* (RHIMAR).
* `call-segments-threshold0.5.csv`: Number of BirdNET detections, called 'number of call segments (num_call_segments)' in this csv file, for each site and species. Detection threshold was set to 0.5.
* `embedding.csv`: BirdNET embeddings of annotated dataset.



### Code

* `BirdNET-training-inference.sh`: Code for training and inference using custom BirdNET classifier.

* `figX_...`: R and Python scripts for plotting figures in the original article.
