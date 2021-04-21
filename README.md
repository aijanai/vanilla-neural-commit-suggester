Neural Commit Suggester
=======================
A machine translation system that translates git commit patches to diff messages.

This is an evolution of an implementation presented at FOSDEM 19 for [Neural commit message suggester: Proposing git commit messages with neural networks](https://fosdem.org/2019/schedule/event/ml_on_code_commit_message/), originally based on Google Neural Machine Translation and achieving BLEU 37.6 on Jiang et al. 2017 dataset.

It has been ported to Sockeye 2, it's now based on the Transformer and is over BLEU 40. 

Installation
------------
Install Sockeye the framework through:

```
pip install sockeye -r requirements.gpu-cu100.txt
```

Train the MT
------------
Data has already been tokenized.

Execute `./train-suggester-simple.sh`.

If you have a GPU, comment out `--use-cpu` flag.  
It will take approximately 15GB of GPU RAM on a Tesla P100. Parallel multiple GPUs are supported. Training lasts approximately 1 hour on 3 GPUs.

Predict a commit message
------------------------
You can predict a commit message by specifying your model directory with `--model` parameter and by sending in diffs in a file passed as `--input` parameter, one diff per line (keep reading for the exact specification). 
Output commit messages go in a file specified by `--output` parameter.

```
sockeye-translate --models sockeye-commit-suggester --use-cpu --input valid.3000.diff --output valid.raw.out
```

Diff format translates by replacing newlines with `<nl>` and `+++`/`---` signs in front of file names with `ppp`/`mmm`. Everything must be whitespace tokenized. 
Lines pointing to char references (typically beginning and ending with `@@`) are stripped.

So, the following:
```
--- a/kubernetes/ansible/ansible_config/tasks/docker.yml
+++ b/kubernetes/ansible/ansible_config/tasks/docker.yml
@@ -1,5 +1,8 @@
 - name: Create docker default nexus auth
   template:
     src: ../../ansible/roles/docker/files/docker-config_staging.json.j2
-    dest: ../../ansible/roles/docker/files/docker-config_staging.json
+    dest: "{{item}}"
     force: true
+  with_items:
+    - ../../ansible/roles/jenkins/files/docker-config.json
+    - ../../ansible/roles/docker/files/docker-config_staging.json
```

gets crammed to a single line like: 
```
mmm a / kubernetes / ansible / ansible_config / tasks / docker . yml <nl> ppp b / kubernetes / ansible / ansible_config / tasks / docker . yml <nl>  - name :  Create docker default nexus auth <nl>    template :  <nl>      src :   .  .  /  .  .  / ansible / roles / docker / files / docker-config_staging . json . j2 <nl> -    dest :   .  .  /  .  .  / ansible / roles / docker / files / docker-config_staging . json <nl> +    dest :  "{{item}}" <nl>      force :  true <nl> +  with_items :  <nl> +    -  .  .  /  .  .  / ansible / roles / jenkins / files / docker-config . json <nl> +    -  .  .  /  .  .  / ansible / roles / docker / files / docker-config_staging . json <nl> 
```

The original dataset and convertion script was provided by [Siyuan Jiang](https://sjiang1.github.io/commitgen/) for CommitGen.  
An improved version is available at [https://github.com/aijanai/commit-suggester-dataset-builder](https://github.com/aijanai/commit-suggester-dataset-builder).
