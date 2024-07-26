conda activate BirdNET
cd BirdNET-Analyzer

# Training (validation 10%)
python train.py --i ../annotated-samples/train/ --o checkpoints/custom/Custom_Classifier4 --val_split 0.1 --epochs 100  --autotune --autotune_trials 200


# Inference for all sites
python analyze.py --i /Volumes/D/invasive-frogs/audio --o ../output/BirdNET-output --classifier checkpoints/custom/Custom_Classifier4.tflite --threads 8

# Test data
python analyze.py --i ../annotated-samples/test --o ../output/test-data --classifier checkpoints/custom/Custom_Classifier4.tflite --threads 8
