conda activate BirdNET
cd BirdNET-Analyzer

# Training
python train.py --i ../annotated-samples/train/ --o checkpoints/custom/Custom_Classifier_latest --val_split 0.2 --epochs 100  --autotune --autotune_trials 100


# Inference for all sites
python analyze.py --i /Volumes/D/invasive-frogs/audio --o ../output/BirdNET-output --classifier checkpoints/custom/Custom_Classifier_latest.tflite --threads 8

# Test data
python analyze.py --i ../annotated-samples/test --o ../output/test-data --classifier checkpoints/custom/Custom_Classifier_latest.tflite --threads 8

# Playback sound
python analyze.py --i ../data/playback --o ../output/playback --classifier checkpoints/custom/Custom_Classifier_latest.tflite --threads 8
