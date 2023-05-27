# Training-Guides

## Training on LUMI

### Create directories
```
mkdir /scratch/project_462000259/$USER
mkdir $HOME/logs
mkdir $HOME/training_scripts
```

### Find absolute paths


```
realpath /scratch/project_462000259
realpath $HOME/logs
```

### Modify bashrc


```
nano ~/.bashrc # or use a text editor of your choice
```

```

export SCRATCH=**realpath to scratch dir**
export PROJECT_HOME=/pfs/lustrep4/projappl/project_462000259
export PATH="$PROJECT_HOME/software/git-lfs-3.3.0/:$PATH"
export LOG_DIR=**realpath to home dir + logs** # eg. /pfs/lustrep4/users/npersaud/logs/
```

Next run this command 
```
source ~/.bashrc
```

### Set up training environment

```
cp $SCRATCH/training_templates/run_sing_deep.sh  $HOME/training_scripts
cp $SCRATCH/training_templates/train1bil_deep.sbatch $HOME/training_scripts
```

These two scripts along with config are what you should modify based on the your needs

To create a new training config, append your config details to this file

```
nano $SCRATCH/mdel_builds/MDEL/src/mdel/configs/config.yaml
```

#### Download a dataset

Before downloading, check the shared datasets folder to ensure that the data does not already exist

The shared datasets folder can be found here 

	$SCRATCH/shared_datasets

Go to the page of the huggingface dataset you want to clone. If you know the full dataset name, you can avoid format the clone command yourself.

##### With the dataset name
```
https://huggingface.co/datasets/entity/dataset_name 
```


##### From the webpage
Locate the clone repository button
![huggingface clone demo](https://github.com/P1ayer-1/Training-Guides/blob/main/hf_clone_demo.png?raw=true)



move to the shared datasets directory
```
cd $SCRATCH/shared_datasets
```


##### Cloning the repo
Set up git lfs
```
git lfs install
```

clone the repository
```
git clone https://huggingface.co/datasets/Multi-Domain-Expert-Layers/philpapers
```


### Start a run

Set `dataset_name` as the path to your dataset in run_sing_deep.sh

#### Execute
```
sbatch $HOME/training_scripts/train1bil_deep.sbatch
```
