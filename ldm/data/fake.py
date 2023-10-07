#!/usr/bin/env python
import torch
from torch.utils.data import Dataset

class FakeDataset(Dataset):
    def __init__(self, img_sz=224, samples=512*1024):
        self.samples = samples
        img = torch.randint(0, 256, (img_sz, img_sz, 3), dtype=torch.uint8)
        caption = "An orange cat is looking at its reflection in the mirror."
        self.data = {
            "jpg": img,
            "caption": caption,
        }

    def __len__(self):
        return self.samples

    def __getitem__(self, i):
        return self.data
