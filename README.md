Neural Commit Suggester
-----------------------

This is the implementation presented at FOSDEM 19 for [Neural commit message suggester: Proposing git commit messages with neural networks](https://fosdem.org/2019/schedule/event/ml_on_code_commit_message/).

Installation
============
Install Sockeye the framework through:

```
pip install sockeye
```

Train the MT
============
Data has already been tokenized.

Execute `train-suggester.sh`.

If you have a GPU, comment out `--use-cpu` flag. It will take approximately 11GB of GPU RAM for 5 hours on a Tesla V100.
